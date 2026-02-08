-module(total_hamming_distance).
-export([total_hamming_distance/1]).

total_hamming_distance(Nums) ->
  N = length(Nums),
  BitCounts = lists:foldl(
    fun(Num, Acc) ->
      lists:zipwith(
        fun(Bit, Count) ->
          Count + Bit
        end,
        int_to_bits(Num),
        Acc
      )
    end,
    lists:duplicate(32, 0),
    Nums
  ),
  lists:foldl(
    fun(Count, Acc) ->
      Acc + Count * (N - Count)
    end,
    0,
    BitCounts
  ).

int_to_bits(Num) ->
  int_to_bits(Num, []).

int_to_bits(0, Bits) ->
  Padding = lists:duplicate(32 - length(Bits), 0),
  lists:reverse(Padding ++ Bits);
int_to_bits(Num, Bits) ->
  Bit = Num rem 2,
  int_to_bits(Num div 2, [Bit | Bits]).