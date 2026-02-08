-spec divide(Dividend :: integer(), Divisor :: integer()) -> integer().
divide(Dividend, Divisor) when Divisor =/= 0 ->
    %% Handle overflow case for -2^31 divided by -1
    case Dividend =:= -2 bsl 31 andalso Divisor =:= -1 of
        true -> 2 bsl 31 - 1;
        false -> 
            %% Determine the sign of the result
            Sign = case (Dividend < 0) andalso (Divisor < 0) of
                       true -> 1;
                       false -> -1
                   end,
            DividendAbs = abs(Dividend),
            DivisorAbs = abs(Divisor),
            divide_helper(DividendAbs, DivisorAbs, 0, Sign)
    end.

%% Helper function to perform the division
-spec divide_helper(DividendAbs :: integer(), DivisorAbs :: integer(), Acc :: integer(), Sign :: integer()) -> integer().
divide_helper(DividendAbs, DivisorAbs, Acc, Sign) when DividendAbs >= DivisorAbs ->
    divide_helper(DividendAbs - DivisorAbs, DivisorAbs, Acc + 1, Sign);
divide_helper(_, _, Acc, Sign) ->
    Sign * Acc.
