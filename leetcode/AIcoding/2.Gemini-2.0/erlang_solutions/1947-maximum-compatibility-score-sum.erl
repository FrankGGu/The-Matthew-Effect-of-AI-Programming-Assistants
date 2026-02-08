-module(maximum_compatibility_score_sum).
-export([max_compatibility_sum/2]).

max_compatibility_sum(Students, Mentors) ->
    N = length(Students),
    max_compatibility_sum_helper(Students, Mentors, lists:seq(1, N), 0).

max_compatibility_sum_helper(Students, Mentors, UnmatchedMentors, CurrentScore) ->
    case Students of
        [] ->
            CurrentScore;
        [Student | RestStudents] ->
            lists:foldl(
                fun(MentorIndex, MaxScoreAcc) ->
                    Mentor = lists:nth(MentorIndex, Mentors),
                    CompatibilityScore = calculate_compatibility_score(Student, Mentor),
                    NewUnmatchedMentors = UnmatchedMentors -- [MentorIndex],
                    NewScore = max_compatibility_sum_helper(
                        RestStudents,
                        Mentors,
                        NewUnmatchedMentors,
                        CurrentScore + CompatibilityScore
                    ),
                    max(MaxScoreAcc, NewScore)
                end,
                0,
                UnmatchedMentors
            )
    end.

calculate_compatibility_score(Student, Mentor) ->
    lists:foldl(
        fun({StudentBit, MentorBit}, ScoreAcc) ->
            if StudentBit == MentorBit then
                ScoreAcc + 1
            else
                ScoreAcc
            end
        end,
        0,
        lists:zip(Student, Mentor)
    ).