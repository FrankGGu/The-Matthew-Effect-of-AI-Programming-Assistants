-module(solution).
-export([min_domino_rotations/2]).

min_domino_rotations(A, B) ->
    N = length(A),
    Target1 = hd(A),
    Target2 = hd(B),

    Res1 = check(Target1, A, B, N),
    Res2 = check(Target2, A, B, N),

    Result =
        if Target1 == Target2 ->
            Res1;
        true ->
            min(Res1, Res2)
        end,

    if Result > N ->
        -1;
    true ->
        Result
    end.

check(Target, A, B, N) ->
    Combined = lists:zip(A, B),
    InitialState = {0, 0}, % {RotationsForA, RotationsForB}

    FinalState = lists:foldl(
        fun({AH, BH}, {CurrentRotA, CurrentRotB}) ->
            case {AH == Target, BH == Target} of
                {true, true} ->
                    {CurrentRotA, CurrentRotB};
                {true, false} ->
                    {CurrentRotA, CurrentRotB + 1};
                {false, true} ->
                    {CurrentRotA + 1, CurrentRotB};
                {false, false} ->
                    % If this domino cannot form the target in either row,
                    % propagate an impossible state. N+1 is a value larger than any valid rotation count.
                    {N + 1, N + 1}
            end
        end,
        InitialState,
        Combined
    ),

    {FinalRotA, FinalRotB} = FinalState,
    min(FinalRotA, FinalRotB).