-module(solution).
-export([convert_to_base7/1]).

-spec convert_to_base7(integer()) -> string().
convert_to_base7(Num) ->
    case Num of
        0 -> "0";
        _ when Num < 0 -> "-" ++ convert_to_base7(-Num);
        _ -> convert_to_base7_positive(Num, [])
    end.

-spec convert_to_base7_positive(integer(), list()) -> string().
convert_to_base7_positive(0, Acc) -> 
    lists:reverse(Acc);
convert_to_base7_positive(Num, Acc) -> 
    convert_to_base7_positive(div(Num, 7), [integer_to_list(rem(Num, 7)) | Acc]).
