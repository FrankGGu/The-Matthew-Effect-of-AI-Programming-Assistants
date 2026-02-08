-module(convert_to_base_neg2).
-export([base_neg2/1]).

base_neg2(0) -> "0";
base_neg2(N) ->
    case N of
        0 -> "0";
        _ ->
            Res = base_neg2(N, []),
            lists:reverse(Res)
    end.

base_neg2(0, Acc) -> Acc;
base_neg2(N, Acc) ->
    Rem = N rem -2,
    N1 = N div -2,
    case Rem of
        0 -> base_neg2(N1, [48 | Acc]);
        1 -> base_neg2(N1, [49 | Acc])
    end.