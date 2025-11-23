-spec max_compatibility_sum(Students :: [[integer()]], Mentors :: [[integer()]]) -> integer().
max_compatibility_sum(Students, Mentors) ->
    M = length(Students),
    N = length(hd(Students)),
    StudentScores = lists:map(fun(Student) -> list_to_tuple(Student) end, Students),
    MentorScores = lists:map(fun(Mentor) -> list_to_tuple(Mentor) end, Mentors),
    Compatibility = lists:map(
        fun(S) ->
            lists:map(
                fun(M) ->
                    Score = lists:foldl(
                        fun(I, Acc) ->
                            case element(I, S) =:= element(I, M) of
                                true -> Acc + 1;
                                false -> Acc
                            end
                        end,
                        0,
                        lists:seq(1, N)
                    ),
                    Score
                end,
                MentorScores
            )
        end,
        StudentScores
    ),
    CompatibilityMatrix = list_to_tuple([list_to_tuple(Row) || Row <- Compatibility]),
    Max = solve(0, M, CompatibilityMatrix, sets:new()),
    Max.

solve(Index, M, Matrix, Used) when Index =:= M ->
    0;
solve(Index, M, Matrix, Used) ->
    MaxScore = 0,
    lists:foldl(
        fun(Mentor, Acc) ->
            case sets:is_element(Mentor, Used) of
                true -> Acc;
                false ->
                    Score = element(Mentor + 1, element(Index + 1, Matrix)),
                    NewUsed = sets:add_element(Mentor, Used),
                    CurrentMax = Score + solve(Index + 1, M, Matrix, NewUsed),
                    max(Acc, CurrentMax)
            end
        end,
        MaxScore,
        lists:seq(0, M - 1)
    ).