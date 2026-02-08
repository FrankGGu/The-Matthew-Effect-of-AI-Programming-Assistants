-module(find_score).
-export([find_score/1]).

find_score(Nums) ->
  find_score_helper(Nums, lists:seq(1, length(Nums)), 0, []).

find_score_helper([], _, Acc, _) ->
  Acc;
find_score_helper(Nums, Indices, Acc, Marked) ->
  case find_min_index_not_marked(Nums, Indices, Marked) of
    none ->
      Acc;
    {Index, Value} ->
      NewMarked = [Index | Marked],
      NewMarked2 = case Index > 1 of
                       true -> [Index - 1 | NewMarked];
                       false -> NewMarked
                   end,
      NewMarked3 = case Index < length(Nums) of
                       true -> [Index + 1 | NewMarked2];
                       false -> NewMarked2
                   end,
      find_score_helper(Nums, Indices, Acc + Value, NewMarked3)
  end.

find_min_index_not_marked(Nums, Indices, Marked) ->
  find_min_index_not_marked_helper(Nums, Indices, Marked, none, 1).

find_min_index_not_marked_helper(_, [], _, Acc, _) ->
  Acc;
find_min_index_not_marked_helper(Nums, [Index | Rest], Marked, Acc, Count) ->
  case lists:member(Index, Marked) of
    true ->
      find_min_index_not_marked_helper(Nums, Rest, Marked, Acc, Count + 1);
    false ->
      case Acc of
        none ->
          find_min_index_not_marked_helper(Nums, Rest, Marked, {Index, lists:nth(Index, Nums)}, Count + 1);
        {_, Value} ->
          NewValue = lists:nth(Index, Nums),
          case NewValue < Value of
            true ->
              find_min_index_not_marked_helper(Nums, Rest, Marked, {Index, NewValue}, Count + 1);
            false ->
              find_min_index_not_marked_helper(Nums, Rest, Marked, Acc, Count + 1)
          end
      end
  end.