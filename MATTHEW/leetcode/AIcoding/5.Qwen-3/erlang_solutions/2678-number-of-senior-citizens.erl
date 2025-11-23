-module(solution).
-export([num_senior_students/1]).

num_senior_students(Passengers) ->
    lists:foldl(fun({_, Age}, Acc) -> if Age >= 60 -> Acc + 1; true -> Acc end end, 0, Passengers).