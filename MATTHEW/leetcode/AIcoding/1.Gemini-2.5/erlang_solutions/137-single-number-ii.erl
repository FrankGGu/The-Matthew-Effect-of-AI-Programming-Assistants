-module(single_number_ii).
-export([single_number/1]).

single_number(Nums) ->
    Result = lists:foldl(
        fun(I, Acc) ->
            Mask = 1 bsl I,
            BitSum = lists:foldl(
                fun(Num, Sum) ->
                    case (Num band Mask) of
                        0 -> Sum;
                        _ -> Sum + 1
                    end
                end,
                0,
                Nums
            ),
            case (BitSum rem 3) of
                0 -> Acc;
                _ -> Acc bor Mask
            end
        end,
        0,
        lists:seq(0, 31)
    ),

    % The problem implies a 32-bit signed integer result.
    % Erlang's integers are arbitrary precision. If the 31st bit is set
    % (indicating a negative number in 32-bit two's complement),
    % the accumulated 'Result' will be a large positive number.
    % We need to convert it to its 32-bit signed equivalent.
    case (Result band (1 bsl 31)) of
        0 -> Result; % Positive or zero, no conversion needed
        _ -> Result - (1 bsl 32) % Negative, convert from unsigned 32-bit to signed 32-bit
    end.