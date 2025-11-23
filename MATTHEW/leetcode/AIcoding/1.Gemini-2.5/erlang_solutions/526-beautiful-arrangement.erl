-module(solution).
-export([countArrangement/1]).

countArrangement(N) ->
    backtrack(N, 1, 0).

backtrack(N, CurrentIndex, Mask) when CurrentIndex > N ->
    1;
backtrack(N, CurrentIndex, Mask) ->
    lists:foldl(fun(Num, Acc) ->
        IfUsed = (Mask band (1 bsl (Num - 1))),
        if
            IfUsed == 0 ->
                if
                    Num rem CurrentIndex == 0;
                    CurrentIndex rem Num == 0 ->
                        Acc + backtrack(N, CurrentIndex + 1, Mask bor (1 bsl (Num - 1)));
                    true ->
                        Acc
                end;
            true ->
                Acc
        end
    end, 0, lists:seq(1, N)).