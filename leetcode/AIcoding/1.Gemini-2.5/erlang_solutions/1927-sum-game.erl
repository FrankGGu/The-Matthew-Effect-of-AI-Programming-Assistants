-module(solution).
-export([sum_game/1]).

sum_game(Num) ->
    Len = length(Num),
    HalfLen = Len div 2,

    {S1, Q1} = calculate_half(lists:sublist(Num, 1, HalfLen)),
    {S2, Q2} = calculate_half(lists:sublist(Num, HalfLen + 1, HalfLen)),

    DiffS = S1 - S2,
    DiffQ = Q1 - Q2,

    % Bob wins if 2 * (S1 - S2) == 9 * (Q2 - Q1)
    % which is equivalent to 2 * (S1 - S2) == -9 * (Q1 - Q2)
    % or 2 * DiffS == -9 * DiffQ

    IfBobWins = (2 * DiffS) == (-9 * DiffQ),

    if IfBobWins ->
        "Bob"
    else ->
        "Alice"
    end.

calculate_half(HalfNum) ->
    lists:foldl(fun(Char, {Sum, QCount}) ->
        if Char == $? ->
            {Sum, QCount + 1};
        true ->
            {Sum + (Char - $0), QCount}
        end
    end, {0, 0}, HalfNum).