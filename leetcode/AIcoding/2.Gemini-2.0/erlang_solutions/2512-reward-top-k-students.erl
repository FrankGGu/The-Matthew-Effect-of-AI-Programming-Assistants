-module(reward_top_k_students).
-export([reward_top_k/5]).

reward_top_k(positive_feedback, negative_feedback, student_reports, student_ids, k) ->
  PositiveSet = sets:from_list(positive_feedback),
  NegativeSet = sets:from_list(negative_feedback),
  ScoredStudents = lists:map(
    fun(Report, Id) ->
      Score = calculate_score(Report, PositiveSet, NegativeSet),
      {Score, Id}
    end,
    student_reports, student_ids
  ),
  SortedStudents = lists:sort(fun({S1, _}, {S2, _}) -> S1 > S2 end, ScoredStudents),
  TopKStudents = lists:sublist(SortedStudents, 1, k),
  [Id || {_Score, Id} <- TopKStudents].

calculate_score(Report, PositiveSet, NegativeSet) ->
  Words = string:tokens(Report, " "),
  Score = lists:foldl(
    fun(Word, Acc) ->
      case sets:is_element(Word, PositiveSet) of
        true -> Acc + 3;
        false ->
          case sets:is_element(Word, NegativeSet) of
            true -> Acc - 1;
            false -> Acc
          end
      end
    end,
    0,
    Words
  ),
  Score.