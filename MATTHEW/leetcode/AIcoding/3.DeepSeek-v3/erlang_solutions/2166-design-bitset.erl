-module(bitset).
-export([init/1, fix/2, unfix/2, flip/1, all/1, one/1, count/1, to_string/1]).

-record(bitset, {
    size :: integer(),
    bits :: list(integer()),
    flipped :: boolean()
}).

init(Size) ->
    #bitset{size = Size, bits = lists:duplicate(Size, 0), flipped = false}.

fix(Bitset, Idx) ->
    Idx1 = Idx + 1,
    case Bitset#bitset.flipped of
        false ->
            NewBits = set_element(Idx1, 1, Bitset#bitset.bits),
            Bitset#bitset{bits = NewBits};
        true ->
            NewBits = set_element(Idx1, 0, Bitset#bitset.bits),
            Bitset#bitset{bits = NewBits}
    end.

unfix(Bitset, Idx) ->
    Idx1 = Idx + 1,
    case Bitset#bitset.flipped of
        false ->
            NewBits = set_element(Idx1, 0, Bitset#bitset.bits),
            Bitset#bitset{bits = NewBits};
        true ->
            NewBits = set_element(Idx1, 1, Bitset#bitset.bits),
            Bitset#bitset{bits = NewBits}
    end.

flip(Bitset) ->
    Bitset#bitset{flipped = not Bitset#bitset.flipped}.

all(Bitset) ->
    case Bitset#bitset.flipped of
        false ->
            lists:all(fun(X) -> X =:= 1 end, Bitset#bitset.bits);
        true ->
            lists:all(fun(X) -> X =:= 0 end, Bitset#bitset.bits)
    end.

one(Bitset) ->
    case Bitset#bitset.flipped of
        false ->
            lists:any(fun(X) -> X =:= 1 end, Bitset#bitset.bits);
        true ->
            lists:any(fun(X) -> X =:= 0 end, Bitset#bitset.bits)
    end.

count(Bitset) ->
    case Bitset#bitset.flipped of
        false ->
            lists:sum(Bitset#bitset.bits);
        true ->
            Bitset#bitset.size - lists:sum(Bitset#bitset.bits)
    end.

to_string(Bitset) ->
    case Bitset#bitset.flipped of
        false ->
            lists:map(fun(X) -> X + $0 end, Bitset#bitset.bits);
        true ->
            lists:map(fun(X) -> (1 - X) + $0 end, Bitset#bitset.bits)
    end.

set_element(1, Val, [_ | T]) -> [Val | T];
set_element(N, Val, [H | T]) when N > 1 -> [H | set_element(N - 1, Val, T)].