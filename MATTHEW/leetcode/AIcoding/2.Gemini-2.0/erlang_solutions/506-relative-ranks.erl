-module(relative_ranks).
-export([relative_ranks/1]).

relative_ranks(Score) ->
  Len = length(Score),
  SortedScore = lists:sort(fun(A, B) -> B - A end, Score),
  Ranks = lists:seq(1, Len),
  RankMap = lists:zip(SortedScore, Ranks),
  Result = [get_rank(S, RankMap, Len) || S <- Score],
  Result.

get_rank(Score, RankMap, Len) ->
  case lists:keyfind(Score, 1, RankMap) of
    {_, 1} -> "Gold Medal";
    {_, 2} -> "Silver Medal";
    {_, 3} -> "Bronze Medal";
    {_, Rank} -> integer_to_list(Rank);
    false -> "" % Should not happen
  end.