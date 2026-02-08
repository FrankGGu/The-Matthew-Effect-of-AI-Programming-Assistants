-module(solution).
-export([num_ways/1]).

num_ways(Str) ->
    num_ways(Str, 0, 0, 0).

num_ways([], _, _, Acc) ->
    Acc;
num_ways([H | T], Count, LastPos, Acc) ->
    case H of
        $| ->
            if
                Count == 0 ->
                    num_ways(T, Count + 1, 0, Acc);
                true ->
                    num_ways(T, Count, LastPos + 1, Acc)
            end;
        _ ->
            if
                Count == 0 ->
                    num_ways(T, Count, LastPos, Acc);
                true ->
                    num_ways(T, Count, LastPos + 1, Acc * (LastPos + 1))
            end
    end.