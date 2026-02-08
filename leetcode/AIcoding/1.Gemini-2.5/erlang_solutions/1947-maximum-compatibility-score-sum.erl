-module(solution).
-export([maxCompatibilitySum/2]).

compatibility_score(Answers1, Answers2) ->
    lists:foldl(fun({A1, A2}, Acc) ->
                    if A1 == A2 -> Acc + 1;
                       true -> Acc
                    end
                end, 0, lists:zip(Answers1, Answers2)).

maxCompatibilitySum(Students, Mentors) ->
    N = length(Students),

    ScoreMatrix =
        [ [ compatibility_score(Student, Mentor) || Mentor <- Mentors ]
          || Student <- Students ],

    MentorIndices = lists:seq(0, N - 1),
    Permutations = lists:permute(MentorIndices),

    lists:foldl(fun(Permutation, MaxScore) ->
                    CurrentScore =
                        lists:foldl(fun({StudentIdx, MentorAssignedIdx}, Acc) ->
                                        StudentRow = lists:nth(StudentIdx + 1, ScoreMatrix),
                                        Score = lists:nth(MentorAssignedIdx + 1, StudentRow),
                                        Acc + Score
                                    end, 0, lists:zip(lists:seq(0, N-1), Permutation)),
                    max(MaxScore, CurrentScore)
                end, 0, Permutations).