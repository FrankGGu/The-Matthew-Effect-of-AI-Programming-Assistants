-module(palindrome_rearrangement_queries).
-export([can_make_palindrome_queries/2]).

can_make_palindrome_queries(S, Queries) ->
  PrefixSum = calculate_prefix_sum(S),
  [can_make_palindrome(PrefixSum, L, R, K) || {L, R, K} <- Queries].

calculate_prefix_sum(S) ->
  calculate_prefix_sum(S, 0, []).

calculate_prefix_sum([], _, Acc) ->
  lists:reverse(Acc);
calculate_prefix_sum([H|T], Index, Acc) ->
  UpdatedBitset = update_bitset(lists:nth(Index+1, S)- $a, lists:last(Acc, 0)),
  calculate_prefix_sum(T, Index+1, [UpdatedBitset | Acc]).

update_bitset(Index, Bitset) ->
  1 bsl Index bxor Bitset.

lists:last([], Default) -> Default;
lists:last(List, _) -> lists:last(List).

can_make_palindrome(PrefixSum, L, R, K) ->
  Value = PrefixSum[R+1] bxor PrefixSum[L],
  SetBits = count_set_bits(Value),
  SetBits div 2 =< K.

count_set_bits(N) ->
  count_set_bits(N, 0).

count_set_bits(0, Count) ->
  Count;
count_set_bits(N, Count) ->
  count_set_bits(N band (N-1), Count+1).