-module(solution).
-export([intersection_size_two/1]).

intersection_size_two(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> 
                            if A =:= B -> false; true -> A < B end 
                        end, Intervals),
    process(Sorted, -1, -1, 0).

process([], _, _, Count) -> Count;
process([[Start, End] | Rest], Last1, Last2, Count) ->
    if
        Start > Last2 ->
            NewCount = Count + 2,
            NewLast1 = End - 1,
            NewLast2 = End,
            process(Rest, NewLast1, NewLast2, NewCount);
        Start > Last1 ->
            NewCount = Count + 1,
            NewLast1 = if Last2 =:= End -> Last2 - 1; true -> Last2 end,
            NewLast2 = End,
            process(Rest, NewLast1, NewLast2, NewCount);
        true ->
            process(Rest, Last1, Last2, Count)
    end.