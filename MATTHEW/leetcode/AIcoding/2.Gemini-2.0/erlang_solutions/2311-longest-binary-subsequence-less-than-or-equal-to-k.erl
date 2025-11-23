-module(longest_binary_subsequence).
-export([solve/2]).

solve(S, K) ->
    solve(S, K, 0, 0).

solve([], _, _, Len) ->
    Len;
solve([C | Rest], K, Value, Len) ->
    case C of
        48 ->
            solve(Rest, K, Value, Len + 1);
        49 ->
            NewValue = Value * 2 + 1;
            if NewValue =< K ->
                solve(Rest, K, NewValue, Len + 1);
            true ->
                solve(Rest, K, Value, Len)
            end
    end.