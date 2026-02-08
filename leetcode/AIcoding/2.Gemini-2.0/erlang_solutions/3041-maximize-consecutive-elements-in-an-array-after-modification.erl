-module(maximize_consecutive_elements).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0, lists:sort(Nums)).

solve([], _, MaxLen, _) ->
    MaxLen;
solve([H | T], CurrLen, MaxLen, Sorted) ->
    case Sorted of
        [] ->
            solve(T, CurrLen + 1, MaxLen, []);
        [SH | ST] ->
            if H =:= SH orelse H =:= SH + 1 then
                solve(T, CurrLen + 1, max(MaxLen, CurrLen + 1), ST)
            else
                solve(T, CurrLen, max(MaxLen, CurrLen), Sorted)
            end
    end.