-module(solution).
-export([max_compatibility_sum/2]).

max_compatibility_sum(Students, Topics) ->
    StudentsCount = length(Students),
    TopicsCount = length(hd(Students)),
    Combinations = lists:seq(0, (1 bsl StudentsCount) - 1),
    lists:max(lists:map(fun(Combination) -> compatibility_score(Combination, Students, Topics, 0) end, Combinations)).

compatibility_score(Combination, Students, Topics, Index) ->
    case Combination of
        0 -> 0;
        _ ->
            StudentIndex = Index,
            Score = lists:foldl(fun(I, Acc) ->
                if
                    (Combination band (1 bsl I)) > 0 -> 
                        Acc + calculate_score(lists:nth(StudentIndex + 1, Students), lists:nth(I + 1, Topics));
                    true ->
                        Acc
                end
            end, 0, lists:seq(0, length(Students) - 1)),
            compatibility_score(Combination bsr 1, Students, Topics, StudentIndex + 1) + Score
    end.

calculate_score(Student, Topic) ->
    lists:sum(lists:map(fun({S, T}) -> if S == T -> 1; true -> 0 end end, lists:zip(Student, Topic)).