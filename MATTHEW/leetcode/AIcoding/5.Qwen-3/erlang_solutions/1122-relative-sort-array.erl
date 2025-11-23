-module(relative_sort_array).
-export([relative_sort/2]).

relative_sort(A, B) ->
    Map = maps:from_list([{Val, Pos} || {Pos, Val} <- lists:zip(lists:seq(0, length(B)-1), B)]),
    SortFun = fun(X, Y) ->
        case maps:find(X, Map) of
            {ok, XPos} ->
                case maps:find(Y, Map) of
                    {ok, YPos} ->
                        if XPos < YPos -> less; true -> greater end;
                    error ->
                        case maps:find(Y, Map) of
                            error -> if X < Y -> less; true -> greater end;
                            _ -> greater
                        end
                end;
            error ->
                case maps:find(Y, Map) of
                    {ok, YPos} -> less;
                    error -> if X < Y -> less; true -> greater end
                end
        end
    end,
    lists:sort(SortFun, A).