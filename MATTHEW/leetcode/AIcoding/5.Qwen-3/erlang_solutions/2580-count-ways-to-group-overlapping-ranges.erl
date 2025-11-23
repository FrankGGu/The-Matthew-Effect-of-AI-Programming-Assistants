-module(solution).
-export([num_ways/1]).

num_ways(Ranges) ->
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A =< C end, Ranges),
    {_, Count} = lists:foldl(fun({Start, End}, {PrevEnd, Acc}) ->
        if
            Start > PrevEnd -> {End, Acc + 1};
            true -> {max(PrevEnd, End), Acc}
        end
    end, {0, 0}, Sorted),
    Count.