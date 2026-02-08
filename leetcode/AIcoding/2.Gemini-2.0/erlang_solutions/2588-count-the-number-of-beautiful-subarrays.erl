-module(beautiful_subarrays).
-export([countBeautifulSubarrays/1]).

countBeautifulSubarrays(Nums) ->
    countBeautifulSubarraysHelper(Nums, 0, #{0 => 1}).

countBeautifulSubarraysHelper([], _, Acc) ->
    maps:get(0, Acc, 0);
countBeautifulSubarraysHelper([H|T], Xor, Acc) ->
    NewXor = Xor bxor H,
    Count = maps:get(NewXor, Acc, 0),
    NewAcc = maps:update_with(NewXor, fun(V) -> V + 1 end, 1, Acc),
    countBeautifulSubarraysHelper(T, NewXor, NewAcc) + Count.