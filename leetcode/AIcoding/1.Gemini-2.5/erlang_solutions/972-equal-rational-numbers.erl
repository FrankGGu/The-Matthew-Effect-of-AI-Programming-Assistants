-module(solution).
-export([isRationalEqual/2]).

pow_iter(_Base, 0, Acc) -> Acc;
pow_iter(Base, Exp, Acc) when Exp > 0 -> pow_iter(Base, Exp - 1, Acc * Base).

pow(Base, Exp) -> pow_iter(Base, Exp, 1).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

parse_string(S) ->
    case string:str(S, ".") of
        0 -> %% No decimal point, so it's just an integer part.
            {S, "", ""};
        DotIdx ->
            IntegerStr = string:substr(S, 1, DotIdx - 1),
            AfterDot = string:substr(S, DotIdx + 1),
            case string:str(AfterDot, "(") of
                0 -> %% No repeating part.
                    {IntegerStr, AfterDot, ""};
                ParenIdx ->
                    FractionalStr = string:substr(AfterDot, 1, ParenIdx - 1),
                    RepeatingPartWithParen = string:substr(AfterDot, ParenIdx),
                    %% Extract the repeating part by removing the parentheses.
                    RepeatingStr = string:substr(RepeatingPartWithParen, 2, length(RepeatingPartWithParen) - 2),
                    {IntegerStr, FractionalStr, RepeatingStr}
            end
    end.

calculate_fraction(IntegerStr, FractionalStr, RepeatingStr) ->
    I = list_to_integer(IntegerStr),
    NF = case FractionalStr of "" -> 0; _ -> list_to_integer(FractionalStr) end,
    R = case RepeatingStr of "" -> 0; _ -> list_to_integer(RepeatingStr) end,

    K = length(FractionalStr), %% Length of non-repeating part
    M = length(RepeatingStr),   %% Length of repeating part

    case M of
        0 -> %% No repeating part (e.g., "123", "123.456")
            case K of
                0 -> %% No fractional part at all (e.g., "123")
                    {I, 1};
                _ -> %% Non-repeating fractional part (e.g., "123.456")
                    Pow10K = pow(10, K),
                    Numerator = I * Pow10K + NF,
                    Denominator = Pow10K,
                    CommonDiv = gcd(Numerator, Denominator),
                    {Numerator div CommonDiv, Denominator div CommonDiv}
            end;
        _ -> %% Repeating fractional part (e.g., "123.4(56)")
            Pow10K = pow(10, K),
            Pow10M = pow(10, M),

            %% Formula for I.NF(R) = (I * 10^K * (10^M - 1) + NF * (10^M - 1) + R) / (10^K * (10^M - 1))
            Numerator = I * Pow10K * (Pow10M - 1) + NF * (Pow10M - 1) + R,
            Denominator = Pow10K * (Pow10M - 1),

            CommonDiv = gcd(Numerator, Denominator),
            {Numerator div CommonDiv, Denominator div CommonDiv}
    end.

isRationalEqual(S, T) ->
    FractionS = string_to_fraction(S),
    FractionT = string_to_fraction(T),
    FractionS =:= FractionT.

string_to_fraction(S) ->
    {IntegerStr, FractionalStr, RepeatingStr} = parse_string(S),
    calculate_fraction(IntegerStr, FractionalStr, RepeatingStr).