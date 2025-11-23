-module(solution).
-export([baseNeg2/1]).

baseNeg2(0) ->
    "0";
baseNeg2(N) ->
    lists:reverse(int_to_base_neg2(N, [])).

int_to_base_neg2(0, Acc) ->
    Acc;
int_to_base_neg2(N, Acc) ->
    Rem = N rem 2,
    case Rem of
        0 ->
            Digit = $0,
            NextN = N div -2,
            int_to_base_neg2(NextN, [Digit | Acc]);
        _ -> % Rem is 1 or -1
            Digit = $1,
            NextN = (N - 1) div -2,
            int_to_base_neg2(NextN, [Digit | Acc])
    end.