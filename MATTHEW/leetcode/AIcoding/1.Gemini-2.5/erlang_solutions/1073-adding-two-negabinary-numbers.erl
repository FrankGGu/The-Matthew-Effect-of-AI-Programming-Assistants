-module(solution).
-export([addNegabinary/2]).

addNegabinary(A, B) ->
    RA = lists:reverse(A),
    RB = lists:reverse(B),

    RawResult = add_negabinary_recursive(RA, RB, 0),

    Result = lists:reverse(RawResult),

    remove_leading_zeros(Result).

add_negabinary_recursive([], [], 0) ->
    [];
add_negabinary_recursive(A, B, Carry) ->
    {DigitA, RestA} = get_head_and_tail(A),
    {DigitB, RestB} = get_head_and_tail(B),

    CurrentSum = DigitA + DigitB + Carry,

    {DigitResult, NextCarry} = 
        case CurrentSum of
            -1 -> {1, 1};
            0  -> {0, 0};
            1  -> {1, 0};
            2  -> {0, -1};
            3  -> {1, -1}
        end,

    [DigitResult | add_negabinary_recursive(RestA, RestB, NextCarry)].

get_head_and_tail([]) ->
    {0, []};
get_head_and_tail([H|T]) ->
    {H, T}.

remove_leading_zeros([0]) ->
    [0];
remove_leading_zeros([0|T]) ->
    remove_leading_zeros(T);
remove_leading_zeros(List) ->
    List.