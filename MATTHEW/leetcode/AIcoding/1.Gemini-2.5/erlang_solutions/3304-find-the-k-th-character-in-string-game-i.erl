-module(solution).
-export([findKthBit/2]).

findKthBit(N, K) ->
    CharInt = get_kth_bit_int(N, K),
    case CharInt of
        0 -> $\0;
        1 -> $\1
    end.

get_kth_bit_int(0, 1) ->
    0;
get_kth_bit_int(N, K) ->
    Mid = (1 bsl N) - 1,
    TotalLen = (1 bsl (N+1)) - 1,

    if
        K == Mid + 1 ->
            1;
        K =< Mid ->
            get_kth_bit_int(N - 1, K);
        K > Mid + 1 ->
            NewK = TotalLen - K + 1,
            CharFromPrev = get_kth_bit_int(N - 1, NewK),
            1 - CharFromPrev
    end.