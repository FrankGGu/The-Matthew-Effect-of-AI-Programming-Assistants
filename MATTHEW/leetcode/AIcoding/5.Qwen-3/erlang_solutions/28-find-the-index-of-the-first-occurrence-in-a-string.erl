-module(solution).
-export([str_str/2]).

str_str(<<>>, _) -> 0;
str_str(_, <<>>) -> -1;
str_str(S, N) ->
    len(N, LenN),
    len(S, LenS),
    if
        LenN > LenS -> -1;
        true -> find_index(S, N, 0, LenN, LenS)
    end.

len(B, L) when is_binary(B) -> L = byte_size(B).

find_index(S, N, I, LenN, LenS) ->
    case compare(S, N, I, 0, LenN) of
        true -> I;
        false ->
            if
                I + LenN >= LenS -> -1;
                true -> find_index(S, N, I + 1, LenN, LenS)
            end
    end.

compare(S, N, I, J, LenN) when J == LenN -> true;
compare(S, N, I, J, LenN) ->
    case I + J < byte_size(S) of
        true ->
            case (binary_part(S, I + J, 1) == binary_part(N, J, 1)) of
                true -> compare(S, N, I, J + 1, LenN);
                false -> false
            end;
        false -> false
    end.