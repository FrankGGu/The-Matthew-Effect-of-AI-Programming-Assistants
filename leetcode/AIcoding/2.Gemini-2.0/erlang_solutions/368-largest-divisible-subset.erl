-module(largest_divisible_subset).
-export([largest_divisible_subset/1]).

largest_divisible_subset(Nums) ->
  SortedNums = lists:sort(Nums),
  N = length(SortedNums),
  {DP, Prev} = lists:foldl(
    fun(Num, {D, P}) ->
      {NewD, NewP} = lists:foldl(
        fun(Index, {AccD, AccP}) ->
          PrevNum = lists:nth(Index + 1, SortedNums),
          if Num rem PrevNum == 0 andalso D =:= [] orelse Num rem PrevNum == 0 andalso lists:nth(Index + 1, D) + 1 > hd(AccD) then
            {[lists:nth(Index + 1, D) + 1 | AccD], [Index | AccP]}
          else
            {AccD, AccP}
          end
        end,
        {[1], [-1]},
        lists:seq(0, N - 2)
      ),
      {[hd(NewD) | D], [hd(NewP) | P]}
    end,
    {[], []},
    SortedNums
  ),
  MaxIndex = lists:foldl(
    fun(Index, Acc) ->
      if lists:nth(Index + 1, DP) > lists:nth(Acc + 1, DP) then
        Index
      else
        Acc
      end
    end,
    0,
    lists:seq(0, N - 1)
  ),
  build_subset(MaxIndex, SortedNums, Prev).

build_subset(Index, SortedNums, Prev) ->
  build_subset(Index, SortedNums, Prev, []).

build_subset(-1, _, _, Acc) ->
  lists:reverse(Acc);
build_subset(Index, SortedNums, Prev, Acc) ->
  build_subset(lists:nth(Index + 1, Prev), SortedNums, Prev, [lists:nth(Index + 1, SortedNums) | Acc]).