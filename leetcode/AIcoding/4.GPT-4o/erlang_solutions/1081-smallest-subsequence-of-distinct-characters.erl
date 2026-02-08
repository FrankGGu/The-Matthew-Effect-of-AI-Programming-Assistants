-module(solution).
-export([smallestSubsequence/1]).

smallestSubsequence(S) ->
    smallest_subsequence(S, [], maps:new(), 0).

smallest_subsequence([], Result, _, _) ->
    lists:reverse(Result);
smallest_subsequence([H | T], Result, Seen, Pos) ->
    case maps:is_key(H, Seen) of
        true ->
            smallest_subsequence(T, Result, Seen, Pos + 1);
        false ->
            NewSeen = maps:put(H, Pos, Seen),
            Result1 = [H | Result],
            Result2 = lists:foldl(fun(X, Acc) ->
                if
                    maps:get(X, Seen) < Pos -> 
                        Acc;
                    true -> 
                        Acc ++ [X]
                end
            end, [], T),
            smallest_subsequence(Result2, Result1, NewSeen, Pos + 1)
    end.