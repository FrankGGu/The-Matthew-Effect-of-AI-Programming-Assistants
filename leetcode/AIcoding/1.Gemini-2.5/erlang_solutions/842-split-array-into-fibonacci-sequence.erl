-module(solution).
-export([split_into_fibonacci/1]).

split_into_fibonacci(S) ->
    case solve(list_to_binary(S), []) of
        false -> [];
        Result -> Result
    end.

solve(S_bin, Acc) ->
    LenS = byte_size(S_bin),
    if LenS == 0 ->
        if length(Acc) >= 3 -> lists:reverse(Acc);
        else -> false
        end;
    true ->
        MaxInt = 2147483647, % 2^31 - 1
        solve_loop(1, LenS, S_bin, Acc, MaxInt)
    end.

solve_loop(I, LenS, S_bin, Acc, MaxInt) when I =< LenS ->
    PrefixBin = binary:part(S_bin, 0, I),
    RestBin = binary:part(S_bin, I, LenS - I),

    % Check for leading zero (e.g., "01" is invalid, but "0" is valid)
    case I > 1 andalso binary:at(PrefixBin, 0) == $0 of
        true ->
            solve_loop(I + 1, LenS, S_bin, Acc, MaxInt);
        false ->
            Num = binary_to_integer(PrefixBin),
            % Check for overflow (number must be <= 2^31 - 1)
            if Num > MaxInt ->
                solve_loop(I + 1, LenS, S_bin, Acc, MaxInt);
            true ->
                case Acc of
                    [B, A | _] when length(Acc) >= 2 -> % We have at least two numbers in the sequence
                        Sum = A + B,
                        if Num == Sum ->
                            case solve(RestBin, [Num | Acc]) of
                                false -> solve_loop(I + 1, LenS, S_bin, Acc, MaxInt);
                                Result -> Result
                            end;
                        Num > Sum -> % Optimization: if current number is already too large, no need to try longer prefixes
                            false;
                        true -> % Num < Sum, this path is not valid, try next prefix length
                            solve_loop(I + 1, LenS, S_bin, Acc, MaxInt)
                        end;
                    _ -> % Acc has 0 or 1 elements, so any number is valid as the first or second
                        case solve(RestBin, [Num | Acc]) of
                            false -> solve_loop(I + 1, LenS, S_bin, Acc, MaxInt);
                            Result -> Result
                        end
                end
            end
    end;
solve_loop(_I, _LenS, _S_bin, _Acc, _MaxInt) ->
    false. % No valid number found for this path with current Acc