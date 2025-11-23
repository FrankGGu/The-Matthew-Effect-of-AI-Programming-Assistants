-module(max_avg_pass_ratio).
-export([max_average_ratio/2]).

max_average_ratio(Classes, ExtraStudents) ->
    PriorityQueue = pq:new(fun([A, B]) -> (A + 1) / (B + 1) - A / B end),
    FilledPQ = lists:foldl(fun([A, B], PQ) -> pq:push([A, B], PQ) end, PriorityQueue, Classes),
    FinalPQ = add_students(FilledPQ, ExtraStudents),
    calculate_avg(FinalPQ).

add_students(PQ, 0) -> PQ;
add_students(PQ, N) ->
    {[A, B], NewPQ} = pq:pop(PQ),
    UpdatedPQ = pq:push([A + 1, B + 1], NewPQ),
    add_students(UpdatedPQ, N - 1).

calculate_avg(PQ) ->
    {Sum, Count} = pq:fold(fun([A, B], {AccSum, AccCount}) ->
        {AccSum + A / B, AccCount + 1}
    end, {0.0, 0}, PQ),
    Sum / Count.