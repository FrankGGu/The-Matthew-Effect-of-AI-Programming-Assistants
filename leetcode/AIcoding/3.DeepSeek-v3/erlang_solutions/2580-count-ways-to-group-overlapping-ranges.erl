-module(solution).
-export([count_ways/1]).

count_ways(Ranges) ->
    Sorted = lists:sort(fun([A, B], [C, D]) -> 
                            if A =:= C -> B =< D;
                               true -> A < C
                            end
                        end, Ranges),
    {Merged, _} = lists:foldl(fun([Start, End], {Acc, PrevEnd}) ->
                                     if Start > PrevEnd ->
                                            {[[Start, End] | Acc], End};
                                        true ->
                                            NewEnd = max(End, PrevEnd),
                                            [H | T] = Acc,
                                            [PrevStart, _] = H,
                                            {[[PrevStart, NewEnd] | T], NewEnd}
                                     end
                              end, {[], -1}, Sorted),
    NumGroups = length(Merged),
    (1 bsl NumGroups) rem 1000000007.