-module(solution).
-export([top_students/4]).

top_students(Positive_feedback, Negative_feedback, Report, Student_ids, K) ->
    PosSet = sets:from_list(Positive_feedback),
    NegSet = sets:from_list(Negative_feedback),
    Scores = lists:map(fun({Id, Rep}) ->
        Words = string:tokens(Rep, " "),
        Score = lists:foldl(fun(Word, Acc) ->
            case sets:is_element(Word, PosSet) of
                true -> Acc + 3;
                false ->
                    case sets:is_element(Word, NegSet) of
                        true -> Acc - 1;
                        false -> Acc
                    end
            end
        end, 0, Words),
        {Score, Id}
    end, lists:zip(Student_ids, Report)),
    Sorted = lists:sort(fun({S1, Id1}, {S2, Id2}) ->
        if
            S1 > S2 -> true;
            S1 < S2 -> false;
            true -> Id1 < Id2
        end
    end, Scores),
    TopK = lists:sublist(Sorted, K),
    [Id || {_Score, Id} <- TopK].