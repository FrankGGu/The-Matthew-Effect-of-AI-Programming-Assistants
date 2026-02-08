-module(solution).
-export([fractionAddition/1]).

gcd(A, 0) -> abs(A);
gcd(A, B) -> gcd(B, A rem B).

simplify({N, D}) when N == 0 -> {0, 1};
simplify({N, D}) ->
    CommonDivisor = gcd(abs(N), abs(D)),
    SimplifiedN = N div CommonDivisor,
    SimplifiedD = D div CommonDivisor,
    % Ensure denominator is positive
    if SimplifiedD < 0 -> {-SimplifiedN, -SimplifiedD};
       true -> {SimplifiedN, SimplifiedD}
    end.

add_fractions({N1, D1}, {N2, D2}) ->
    NewN = N1 * D2 + N2 * D1,
    NewD = D1 * D2,
    simplify({NewN, NewD}).

parse_number_string(Expression, Index, AccChars) ->
    case Index > length(Expression) of
        true -> {AccChars, Index};
        false ->
            Char = lists:nth(Index, Expression),
            case Char >= $0 andalso Char =< $9 of
                true -> parse_number_string(Expression, Index + 1, [Char | AccChars]);
                false -> {AccChars, Index} % Non-digit character found (e.g., '/', '+', '-', or end of string)
            end
    end.

parse_expression(Expression, Index, AccFraction) ->
    case Index > length(Expression) of
        true -> AccFraction; % End of string
        false ->
            % Determine the sign of the next fraction
            {Sign, NextIndex1} =
                case lists:nth(Index, Expression) of
                    $- -> {-1, Index + 1};
                    $+ -> {1, Index + 1};
                    _  -> {1, Index} % Implicit + for the first fraction if no sign is present
                end,

            % Parse numerator
            {NumStrReversed, NextIndex2} = parse_number_string(Expression, NextIndex1, []),
            Num = list_to_integer(lists:reverse(NumStrReversed)),

            % Skip '/'
            NextIndex3 = NextIndex2 + 1,

            % Parse denominator
            {DenStrReversed, NextIndex4} = parse_number_string(Expression, NextIndex3, []),
            Den = list_to_integer(lists:reverse(DenStrReversed)),

            % Calculate the current fraction to add, applying its sign
            CurrentFraction = {Sign * Num, Den},

            % Add to accumulator and recurse for the rest of the expression
            NewAccFraction = add_fractions(AccFraction, CurrentFraction),
            parse_expression(Expression, NextIndex4, NewAccFraction)
    end.

fractionAddition(Expression) ->
    % Initial accumulator fraction is 0/1
    {FinalNum, FinalDen} = parse_expression(Expression, 1, {0, 1}),
    io_lib:format("~w/~w", [FinalNum, FinalDen]).