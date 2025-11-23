-module(minimum_xor_sum).
-export([minimum_xor_sum/2]).

minimum_xor_sum(Nums1, Nums2) ->
  N = length(Nums1),
  memo = dict:new(),
  minimum_xor_sum_helper(Nums1, Nums2, 0, 0, memo, N).

minimum_xor_sum_helper(_Nums1, _Nums2, Mask, Index, Memo, N) when Index >= N ->
  0;
minimum_xor_sum_helper(Nums1, Nums2, Mask, Index, Memo, N) ->
  case dict:find( {Mask, Index}, Memo) of
    {ok, Val} ->
      Val;
    error ->
      Result = lists:foldl(
                 fun(I, Acc) ->
                   if (Mask band (1 bsl I)) == 0 then
                     Xor_Val = lists:nth(Index + 1, Nums1) bxor lists:nth(I + 1, Nums2),
                     New_Mask = Mask bor (1 bsl I),
                     Acc1 = minimum_xor_sum_helper(Nums1, Nums2, New_Mask, Index + 1, Memo, N),
                     min(Acc, Xor_Val + Acc1)
                   else
                     Acc
                   end
                 end,
                 infinity,
                 lists:seq(0, N - 1)
               ),
      dict:store( {Mask, Index}, Result, Memo),
      Result
  end.

infinity() ->
  1 bsl 60.