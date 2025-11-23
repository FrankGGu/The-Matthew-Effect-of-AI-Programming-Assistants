-module(solution).
-export([accounts_merge/1]).

accounts_merge(Accounts) ->
    % Step 1: Initialize DSU structures and collect all unique emails
    {InitialParentMap, InitialNameMap, AllEmailsSet} = init_dsu(Accounts),

    % Step 2: Build DSU by performing unions for each account
    FinalParentMap = build_dsu(Accounts, InitialParentMap),

    % Step 3: Group emails by their ultimate root, performing path compression again
    GroupedEmails = group_emails(AllEmailsSet, FinalParentMap),

    % Step 4: Format the output
    format_output(GroupedEmails, InitialNameMap).

init_dsu(Accounts) ->
    lists:foldl(
        fun([Name | Emails], {ParentAcc, NameAcc, EmailSetAcc}) ->
            NewParentAcc = lists:foldl(fun(Email, Acc) -> maps:put(Email, Email, Acc) end, ParentAcc, Emails),
            NewNameAcc = lists:foldl(fun(Email, Acc) -> maps:put(Email, Name, Acc) end, NameAcc, Emails),
            NewEmailSetAcc = sets:union(EmailSetAcc, sets:from_list(Emails)),
            {NewParentAcc, NewNameAcc, NewEmailSetAcc}
        end,
        {#{}, #{}, sets:new()}, % Initial state: empty parent map, empty name map, empty email set
        Accounts
    ).

build_dsu(Accounts, ParentMap) ->
    lists:foldl(
        fun([_Name | Emails], CurrentParentMap) ->
            case Emails of
                [] -> CurrentParentMap; % No emails in this account, no unions to perform
                [FirstEmail | RestEmails] ->
                    lists:foldl(
                        fun(Email, AccParentMap) ->
                            union_sets(FirstEmail, Email, AccParentMap)
                        end,
                        CurrentParentMap,
                        RestEmails
                    )
            end
        end,
        ParentMap, % Start with the initial parent map
        Accounts
    ).

find_root_and_update(Email, ParentMap) ->
    Parent = maps:get(Email, ParentMap), % Email must be in ParentMap from init_dsu
    if
        Parent == Email ->
            {Email, ParentMap}; % Email is its own parent, it's a root. No map update needed.
        true ->
            {Root, NewParentMap} = find_root_and_update(Parent, ParentMap),
            {Root, maps:put(Email, Root, NewParentMap)} % Path compression
    end.

union_sets(Email1, Email2, ParentMap) ->
    {Root1, MapAfterFind1} = find_root_and_update(Email1, ParentMap),
    {Root2, MapAfterFind2} = find_root_and_update(Email2, MapAfterFind1), % Use the updated map from previous find
    if
        Root1 =/= Root2 ->
            maps:put(Root2, Root1, MapAfterFind2); % Merge Root2's set into Root1's set
        true ->
            MapAfterFind2 % Roots are already the same, no merge needed, but path compression might have happened
    end.

group_emails(AllEmailsSet, FinalParentMap) ->
    % This fold iterates through all unique emails.
    % For each email, it finds its root and adds the email to the list associated with that root.
    % The `ParentMap` is also updated due to path compression during `find_root_and_update`.
    {Grouped, _FinalMapAfterGrouping} = sets:fold(
        fun(Email, {AccGroupedEmails, AccParentMap}) ->
            {Root, NewParentMap} = find_root_and_update(Email, AccParentMap),
            NewGroupedEmails = maps:update_with(Root, fun(Emails) -> [Email | Emails] end, [Email], AccGroupedEmails),
            {NewGroupedEmails, NewParentMap}
        end,
        {#{}, FinalParentMap}, % Initial accumulator for grouped emails and the parent map
        AllEmailsSet
    ),
    Grouped. % We only care about the grouped emails, not the final parent map after grouping.

format_output(GroupedEmails, NameMap) ->
    % The problem statement says "return the accounts in any order", so sorting the outer list is optional
    % but sorting emails within each account is required.
    lists:sort( % Optional: Sort the final list of accounts for consistent output
        maps:fold(
            fun(Root, EmailsList, Acc) ->
                AccountName = maps:get(Root, NameMap), % Get name from any email in the set (we use the root)
                SortedEmails = lists:sort(EmailsList), % Required: Sort emails within each account
                [[AccountName | SortedEmails] | Acc]
            end,
            [],
            GroupedEmails
        )
    ).