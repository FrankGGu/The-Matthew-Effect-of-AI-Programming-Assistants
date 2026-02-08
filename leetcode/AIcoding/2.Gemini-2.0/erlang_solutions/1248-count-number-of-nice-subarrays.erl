-module(nice_subarrays).
-export([number_of_subarrays/2]).

number_of_subarrays(Nums, K) ->
    count_subarrays(Nums, K, 0, 0, 0).

count_subarrays([], _K, Count, _OddCount, _Start) ->
    Count;
count_subarrays([Num | Rest], K, Count, OddCount, Start) ->
    case Num rem 2 of
        0 ->
            count_subarrays(Rest, K, Count, OddCount, Start);
        1 ->
            NewOddCount = OddCount + 1,
            case NewOddCount =:= K of
                true ->
                    Zeros = count_zeros_before_next_odd(Rest),
                    Count1 = Count + (Zeros + 1) * (Start + 1),
                    count_subarrays(Rest, K, Count1, NewOddCount - 1, find_next_odd(Rest) + 1);
                false ->
                    count_subarrays(Rest, K, Count, NewOddCount, Start + 1)
            end
    end.

find_next_odd([Num | Rest]) ->
    case Num rem 2 of
        1 ->
            0;
        0 ->
            1 + find_next_odd(Rest)
    end;
find_next_odd([]) ->
    0.

count_zeros_before_next_odd([Num | _Rest]) when Num =:= 1 ->
    0;
count_zeros_before_next_odd([0 | Rest]) ->
    1 + count_zeros_before_next_odd(Rest);
count_zeros_before_next_odd([]) ->
    0.

find_next_odd_index(Nums) ->
  find_next_odd_index(Nums, 0).

find_next_odd_index([Num | _], Index) when Num rem 2 == 1 ->
  Index;
find_next_odd_index([_ | Rest], Index) ->
  find_next_odd_index(Rest, Index + 1);
find_next_odd_index([], _Index) ->
  -1.