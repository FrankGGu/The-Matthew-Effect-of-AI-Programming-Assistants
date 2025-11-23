-module(minimum_swaps_to_group_all_ones_together_ii).
-export([min_swaps/1]).

min_swaps(Nums) ->
  Len = length(Nums),
  Ones = lists:sum(Nums),
  case Ones =:= 0 of
    true -> 0;
    false ->
      {_, MinSwaps} = lists:foldl(
        fun(I, {WindowOnes, AccMinSwaps}) ->
          WindowOnes1 = WindowOnes + Nums !! I,
          if I >= Ones then
            WindowOnes2 = WindowOnes1 - Nums !! (I - Ones),
            MinSwaps1 = min(AccMinSwaps, Ones - WindowOnes2),
            {WindowOnes2, MinSwaps1}
          else
            {WindowOnes1, AccMinSwaps}
          end
        end,
        {0, Ones},
        lists:seq(0, Len - 1) ++ lists:seq(0, Ones - 2)
      ),
      MinSwaps
  end.