-module(grid_game).
-export([gridGame/1]).

gridGame(Grid) ->
  N = length(hd(Grid)),
  {PrefixSumRow1, _} = lists:foldl(
    fun(X, {Acc, Index}) ->
      {Acc ++ [ (case Index of 0 -> X; _ -> lists:last(Acc) + X end) ], Index + 1}
    end, {[], 0}, hd(Grid)),

  {SuffixSumRow2, _} = lists:foldl(
    fun(X, {Acc, Index}) ->
      {[(case Index of 0 -> X; _ -> lists:last(Acc) + X end)] ++ Acc, Index + 1}
    end, {[], 0}, lists:reverse(lists:nth(2, Grid))),

  SuffixSumRow2Reversed = lists:reverse(SuffixSumRow2),

  lists:min(
    [ max(
        (case I of
           0 -> 0;
           _ -> lists:nth(I - 1, PrefixSumRow1)
         end),
        (case I of
           N - 1 -> 0;
           _ -> lists:nth(I + 1, SuffixSumRow2Reversed)
         end)
       )
     || I <- lists:seq(0, N - 1)
    ]
  ).