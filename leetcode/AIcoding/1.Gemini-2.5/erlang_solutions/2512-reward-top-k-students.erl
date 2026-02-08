-module(solution).
-export([top_k_students/5]).

top_k_students(PositiveFeedback, NegativeFeedback, Report, StudentID, K) ->
    PositiveSet = sets:from_list(PositiveFeedback),
    NegativeSet = sets:from_list(NegativeFeedback),

    StudentData = lists:zip(Report, StudentID),

    Scores = calculate_scores(StudentData, PositiveSet, NegativeSet, []),

    SortedScores = lists:sort(Scores),

    TopKStudents = lists:sublist(SortedScores, K),

    lists:map(fun({_NegatedScore, ID}) -> ID end, TopKStudents).

calculate_scores([], _PositiveSet, _NegativeSet, Acc) ->
    Acc;
calculate_scores([{ReportStr, ID} | Rest], PositiveSet, NegativeSet, Acc) ->
    Words = string:tokens(ReportStr, " "),
    StudentScore = lists:foldl(
        fun(Word, CurrentScore) ->
            if
                sets:is_element(Word, PositiveSet) -> CurrentScore + 3;
                sets:is_element(Word, NegativeSet) -> CurrentScore - 1;
                true -> CurrentScore
            end
        end,
        0,
        Words
    ),
    calculate_scores(Rest, PositiveSet, NegativeSet, [{ -StudentScore, ID} | Acc]).