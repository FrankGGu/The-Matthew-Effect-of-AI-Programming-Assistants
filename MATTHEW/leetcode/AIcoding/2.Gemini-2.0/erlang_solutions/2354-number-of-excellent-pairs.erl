-module(number_of_excellent_pairs).
-export([count_excellent_pairs/1]).

count_excellent_pairs(Nums) ->
  Counts = lists:foldl(
    fun(Num, Acc) ->
      Bits = count_set_bits(Num);
      maps:update_with(Bits, fun(V) -> V + 1 end, 1, Acc)
    end,
    maps:new(),
    Nums
  ),
  lists:foldl(
    fun({Bits1, Count1}, Acc) ->
      lists:foldl(
        fun({Bits2, Count2}, Acc2) ->
          if Bits1 + Bits2 >= length(integer_to_list(hd(Nums),2)) then
            Acc2 + Count1 * Count2
          else
            Acc2
          end
        end,
        Acc,
        maps:to_list(Counts)
      )
    end,
    0,
    maps:to_list(Counts)
  ).

count_set_bits(N) ->
  count_set_bits(N, 0).

count_set_bits(0, Acc) ->
  Acc;
count_set_bits(N, Acc) ->
  count_set_bits(N band (N - 1), Acc + 1).