-module(solution).
-export([max_overlap/2]).

max_overlap(Image1, Image2) ->
    N = length(Image1),
    Map = maps:new(),
    Count = maps:new(),
    Max = 0,
    Xs = lists:seq(0, N-1),
    Ys = lists:seq(0, N-1),
    lists:foreach(fun(X1) ->
        lists:foreach(fun(Y1) ->
            if
                lists:nth(X1+1, Image1) band (1 bsl Y1) /= 0 ->
                    lists:foreach(fun(X2) ->
                        lists:foreach(fun(Y2) ->
                            if
                                lists:nth(X2+1, Image2) band (1 bsl Y2) /= 0 ->
                                    D = {X1 - X2, Y1 - Y2},
                                    C = maps:get(D, Count, 0) + 1,
                                    maps:put(D, C, Count),
                                    if C > Max -> Max = C; true -> ok end;
                                true -> ok
                            end
                        end, Ys);
                    fun(_) -> ok end
                end
            end, Ys)
        end, Xs),
    Max.

lists:nth(I, L) when is_list(L) -> lists:nth(I, L).
lists:seq(A, B) when A =< B -> lists:seq(A, B).
lists:foreach(F, L) -> lists:foreach(F, L).