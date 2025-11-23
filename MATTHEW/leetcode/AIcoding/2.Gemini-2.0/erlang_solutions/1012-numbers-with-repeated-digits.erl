-module(repeated_digits).
-export([num_dup_digits_at_most_n/1]).

num_dup_digits_at_most_n(N) ->
    digits(N).

digits(N) ->
    L = integer_to_list(N),
    Len = length(L),
    digits_helper(L, Len, true, [], 0).

digits_helper([], 0, _, _, Acc) ->
    Acc;
digits_helper(L, Len, IsExact, Seen, Acc) ->
    Digit = list_to_integer([hd(L)]),
    Rest = tl(L),
    NewLen = Len - 1,

    Max = if IsExact then Digit else 9 end,
    NewAcc = lists:foldl(
        fun(D, A) ->
            case lists:member(D, Seen) of
                true ->
                    A;
                false ->
                    A + factorial_perm(NewLen, length(Seen) + 1)
            end
        end,
        Acc,
        lists:seq(if NewLen == length(L) - 1 and D == 0 then 1 else 0 end, Max)
    ),

    case lists:member(Digit, Seen) of
        true ->
            NewAcc;
        false ->
            NewIsExact = IsExact andalso (Digit == list_to_integer([hd(L)])),
            digits_helper(Rest, NewLen, NewIsExact, [Digit | Seen], NewAcc)
    end.

factorial_perm(N, K) ->
    factorial_perm_helper(N, K, 1).

factorial_perm_helper(N, K, Acc) ->
    if K > N then
        Acc
    else
        factorial_perm_helper(N, K + 1, Acc * (10 - K))
    end.