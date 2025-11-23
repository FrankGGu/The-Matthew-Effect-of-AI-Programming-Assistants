-module(sum_k_mirror).
-export([sum_k_mirror/1]).

sum_k_mirror(N) ->
    sum_k_mirror(N, 2, 1, 0).

sum_k_mirror(0, _, _, Acc) ->
    Acc;
sum_k_mirror(N, K, Len, Acc) ->
    Start = 10**(Len - 1),
    End = 10**Len - 1,
    sum_k_mirror_range(N, K, Start, End, Acc).

sum_k_mirror_range(N, K, Start, End, Acc) ->
    case Start > End of
        true -> sum_k_mirror(N, K + 1, 1, Acc);
        false ->
            Half = integer_to_list(Start),
            Num = list_to_integer(Half ++ lists:reverse(Half)),
            case Num > End of
                true ->
                    NewStart = 10**(length(Half));
                    sum_k_mirror_range(N, K, NewStart, End, Acc);
                false ->
                    case is_k_palindrome(Num, K) of
                        true ->
                            sum_k_mirror_range(N - 1, K, Start + 1, End, Acc + Num);
                        false ->
                            sum_k_mirror_range(N, K, Start + 1, End, Acc)
                    end
            end
    end.

is_k_palindrome(N, K) ->
    BaseK = to_base(N, K),
    BaseK =:= lists:reverse(BaseK).

to_base(0, _) ->
    [];
to_base(N, K) ->
    (N rem K) ++ to_base(N div K, K).