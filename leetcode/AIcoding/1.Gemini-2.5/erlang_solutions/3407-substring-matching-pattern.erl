-module(solution).
-export([isMatch/2]).

-define(MEMO_TABLE, solution_memo_table).

-spec isMatch(S :: string(), P :: string()) -> boolean().
isMatch(S, P) ->
    %% Create a new ETS table for each call to isMatch.
    %% This ensures memoization is fresh for each test case and avoids
    %% interference between different calls.
    ets:new(?MEMO_TABLE, [set, public, named_table]),
    try
        match(S, P)
    after
        %% Ensure the ETS table is deleted after the match operation,
        %% regardless of success or failure.
        ets:delete(?MEMO_TABLE)
    end.

-spec match(S_list :: list(), P_list :: list()) -> boolean().
match(S_list, P_list) ->
    Key = {S_list, P_list},
    case ets:lookup(?MEMO_TABLE, Key) of
        [{Key, Result}] ->
            Result;
        [] ->
            Result = match_impl(S_list, P_list),
            ets:insert(?MEMO_TABLE, {Key, Result}),
            Result
    end.

-spec match_impl(S_list :: list(), P_list :: list()) -> boolean().
match_impl(S_list, P_list) ->
    case P_list of
        [] ->
            %% If pattern is empty, string must also be empty for a match.
            S_list == [];
        [P_head | P_tail] ->
            %% Determine if the first character of S_list matches P_head.
            %% This is true if S_list is not empty AND (S_head == P_head OR P_head == '.').
            FirstMatch = (S_list /= [] andalso (hd(S_list) == P_head orelse P_head == $.)),

            case P_tail of
                [$* | P_tail_after_star] ->
                    %% Case: P_head* followed by P_tail_after_star
                    %% Option 1: P_head* matches zero occurrences of P_head.
                    %% Try matching S_list with the rest of the pattern (P_tail_after_star).
                    (match(S_list, P_tail_after_star)
                     orelse
                     %% Option 2: P_head* matches one or more occurrences of P_head.
                     %% S_head must match P_head, then match the rest of S_list (tl(S_list))
                     %% with the *same* pattern (P_list, which still starts with P_head*).
                     (FirstMatch andalso match(tl(S_list), P_list)));
                _ ->
                    %% Case: No '*' after P_head.
                    %% S_head must match P_head, then match the rest of S_list (tl(S_list))
                    %% with the rest of the pattern (P_tail).
                    FirstMatch andalso match(tl(S_list), P_tail)
            end
    end.