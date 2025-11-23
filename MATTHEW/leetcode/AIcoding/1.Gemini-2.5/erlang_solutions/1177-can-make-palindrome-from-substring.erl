-module(solution).
-export([canMakePaliQueries/2]).

-include_lib("kernel/include/array.hrl").

popcount(N) when N < 0 -> 0;
popcount(0) -> 0;
popcount(N) ->
    1 + popcount(N band (N - 1)).

build_prefix_xor_list(S) ->
    build_prefix_xor_list(S, 0, [0]).

build_prefix_xor_list([], _CurrentMask, Acc) ->
    lists:reverse(Acc);
build_prefix_xor_list([Char | Rest], CurrentMask, Acc) ->
    NewMask = CurrentMask bxor (1 bsl (Char - $a)),
    build_prefix_xor_list(Rest, NewMask, [NewMask | Acc]).

canMakePaliQueries(S, Queries) ->
    PrefixXorList = build_prefix_xor_list(S),
    PrefixXorArray = array:from_list(PrefixXorList),
    lists:map(fun([Left, Right, K]) ->
                      MaskForLeft = array:get(Left, PrefixXorArray),
                      MaskForRightPlusOne = array:get(Right + 1, PrefixXorArray),
                      CurrentMask = MaskForRightPlusOne bxor MaskForLeft,
                      OddFreqCount = popcount(CurrentMask),
                      K >= (OddFreqCount div 2)
              end, Queries).