-module(solution).
-export([chalk_replacement/2]).

chalk_replacement(Chalk, Queries) ->
    Total = lists:sum(Chalk),
    Query = lists:nth(1, Queries),
    case Query rem Total of
        0 -> 0;
        _ -> find_student(Chalk, Query rem Total, 0)
    end.

find_student([], _, _) -> 0;
find_student([H | T], N, Index) ->
    if
        N < H -> Index;
        true -> find_student(T, N - H, Index + 1)
    end.