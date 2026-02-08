-module(reach_end).
-export([max_score/1]).

max_score(nums) ->
  N = length(nums),
  max_score(nums, 0, N - 1, #{}, N).

max_score(Nums, Start, End, Memo, N) ->
  case maps:get(Start, Memo, undefined) of
    Score when is_integer(Score) ->
      Score;
    _ ->
      case Start =:= End of
        true ->
          maps:put(Start, Nums !! Start, Memo);
        false ->
          Score = find_max_score(Nums, Start, End, Memo, N),
          maps:put(Start, Score, Memo)
      end
  end.

find_max_score(Nums, Start, End, Memo, N) ->
  Num = Nums !! Start,
  case Start + Num =< End of
    true ->
      max(Nums !! Start + max_score(Nums, Start + Num + 1, End, Memo, N),
          case Start + 1 =< End of
            true -> max_score(Nums, Start + 1, End, Memo, N);
            false -> -1000000000000000
          end);
    false ->
       case Start + 1 =< End of
            true -> max_score(Nums, Start + 1, End, Memo, N);
            false -> -1000000000000000
          end
  end.