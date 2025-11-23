-module(monotone_increasing_digits).
-export([is_monotonic/1, get_monotonic/1]).

is_monotonic(N) ->
    Digits = integer_to_list(N),
    is_monotonic(Digits).

is_monotonic([]) -> true;
is_monotonic([_]) -> true;
is_monotonic([A,B|T]) when A =< B -> is_monotonic([B|T]);
is_monotonic(_) -> false.

get_monotonic(N) ->
    Digits = integer_to_list(N),
    get_monotonic(Digits, 0, []).

get_monotonic([], _, Acc) ->
    list_to_integer(lists:reverse(Acc));
get_monotonic([H|T], Pos, Acc) ->
    case Pos of
        0 ->
            get_monotonic(T, Pos + 1, [H | Acc]);
        _ ->
            case lists:last(Acc) =< H of
                true ->
                    get_monotonic(T, Pos + 1, [H | Acc]);
                false ->
                    {NewAcc, NewDigit} = adjust(Acc, H),
                    get_monotonic(T, Pos + 1, [NewDigit | NewAcc])
            end
    end.

adjust([], _) -> {[], 0};
adjust([H|T], D) ->
    case H < D of
        true ->
            {lists:reverse([H | T]), D};
        false ->
            {lists:reverse(T), H - 1}
    end.