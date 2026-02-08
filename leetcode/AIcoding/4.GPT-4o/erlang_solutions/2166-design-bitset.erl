-module(bitset).
-export([new/1, fix/2, flip/1, all/0, one/0, count/0, toString/0]).

-record(bitset, {size, bits}).

new(Size) ->
    #bitset{size=Size, bits=lists:duplicate(Size, false)}.

fix(Bitset, idx) ->
    Bits = Bitset#bitset.bits,
    NewBits = lists:replace_element(idx, true, Bits),
    Bitset#bitset{bits=NewBits}.

flip(Bitset, idx) ->
    Bits = Bitset#bitset.bits,
    NewBits = lists:replace_element(idx, not lists:nth(idx+1, Bits), Bits),
    Bitset#bitset{bits=NewBits}.

all(Bitset) ->
    lists:all(fun(X) -> X end, Bitset#bitset.bits).

one(Bitset) ->
    lists:count(true, Bitset#bitset.bits) =:= 1.

count(Bitset) ->
    lists:count(true, Bitset#bitset.bits).

toString(Bitset) ->
    Bits = Bitset#bitset.bits,
    lists:foldl(fun(X, Acc) -> Acc ++ [if X -> '1'; true -> '0' end] end, "", Bits).