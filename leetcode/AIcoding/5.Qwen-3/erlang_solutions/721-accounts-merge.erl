-module(leetcode_accounts_merge).
-export([accounts_merge/1]).

accounts_merge(Accounts) ->
    Users = maps:from_list([{Email, {Name, []}} || [Name | Emails] <- Accounts, Email <- Emails]),
    Parents = maps:from_list([{Email, Email} || [Name | Emails] <- Accounts, Email <- Emails]),
    UnionFind = #{
        users => Users,
        parents => Parents
    },
    merge_accounts(Accounts, UnionFind).

merge_accounts([], _) -> [];
merge_accounts([[Name | Emails] | Rest], UnionFind) ->
    case Emails of
        [] -> merge_accounts(Rest, UnionFind);
        _ ->
            First = hd(Emails),
            lists:foldl(fun(Email, UF) ->
                            union(First, Email, UF)
                        end, UnionFind, tl(Emails)),
            merge_accounts(Rest, UnionFind)
    end.

union(A, B, #{users := Users, parents := Parents} = UF) ->
    RootA = find(A, Parents),
    RootB = find(B, Parents),
    if
        RootA == RootB -> UF;
        true ->
            NewParents = maps:put(RootB, RootA, Parents),
            #{UF | parents := NewParents}
    end.

find(A, Parents) ->
    case maps:get(A, Parents) of
        A -> A;
        Parent -> find(Parent, Parents)
    end.

merge_accounts_result(UnionFind) ->
    Users = maps:get(users, UnionFind),
    Parents = maps:get(parents, UnionFind),
    Groups = maps:fold(fun(Email, {Name, _}, Acc) ->
                           Root = find(Email, Parents),
                           maps:update_with(Root, fun(Emails) -> [Email | Emails] end, [Email], Acc)
                       end, #{}, Users),
    lists:sort([lists:sort([Name | lists:reverse(Emails)]) || {Name, Emails} <- maps:values(Groups)]).

accounts_merge(Accounts) ->
    Users = maps:from_list([{Email, {Name, []}} || [Name | Emails] <- Accounts, Email <- Emails]),
    Parents = maps:from_list([{Email, Email} || [Name | Emails] <- Accounts, Email <- Emails]),
    UnionFind = #{
        users => Users,
        parents => Parents
    },
    merge_accounts(Accounts, UnionFind),
    merge_accounts_result(UnionFind).