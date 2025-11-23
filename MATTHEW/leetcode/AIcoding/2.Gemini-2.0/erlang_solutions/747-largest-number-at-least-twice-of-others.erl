-module(largest_number_at_least_twice_of_others).
-export([dominantIndex/1]).

dominantIndex(Nums) ->
  {Max, MaxIndex} = lists:foldl(
    fun(N, {CurrentMax, CurrentMaxIndex}) ->
      if N > CurrentMax then
        {N, lists:seq(1, length(Nums)) -- [CurrentMaxIndex] -- [lists:nth(length(Nums) - lists:seq(1, length(Nums)), Nums)] -- [lists:nth(length(Nums) - lists:seq(1, length(Nums)), Nums)]}
      else
        {CurrentMax, CurrentMaxIndex}
      end
    end,
    {hd(Nums), 1},
    lists:seq(2, length(Nums)),
    Nums).

  case lists:all(fun(N) -> N * 2 =< Max end, lists:delete(Max, Nums)) of
    true -> lists:nth(MaxIndex, Nums);
    false -> -1
  end.

dominantIndex(Nums) ->
    {Max, MaxIndex} = lists:foldl(
        fun({N, Index}, {CurrentMax, CurrentMaxIndex}) ->
            if N > CurrentMax then
                {N, Index}
            else
                {CurrentMax, CurrentMaxIndex}
            end
        end,
        {hd(Nums), 1},
        lists:zip(lists:nthtail(1, Nums), lists:seq(2, length(Nums)))
    ),

    if lists:all(fun(N) -> N * 2 =< Max end, lists:delete(Max, Nums)) then
        MaxIndex - 1
    else
        -1
    end.