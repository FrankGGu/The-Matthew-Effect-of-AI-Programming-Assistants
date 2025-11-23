-module(solution).
-export([decode_string/1]).

decode_string(S) ->
    Chars = binary_to_list(S),
    {ResultList, _} = decode_recursive(Chars),
    list_to_binary(ResultList).

parse_number(Chars) ->
    parse_number(Chars, 0).

parse_number([], Acc) -> {Acc, []};
parse_number([H|T], Acc) when H >= $0, H =< $9 ->
    Digit = H - $0,
    parse_number(T, Acc * 10 + Digit);
parse_number(Chars, Acc) ->
    {Acc, Chars}.

repeat_string(Str, N) ->
    lists:flatten(lists:duplicate(N, Str)).

decode_recursive(Chars) ->
    decode_recursive(Chars, []).

decode_recursive([], Acc) ->
    {lists:reverse(Acc), []};
decode_recursive([$]|T], Acc) ->
    {lists:reverse(Acc), [$]|T]};
decode_recursive([H|T], Acc) when H >= $a, H =< $z ->
    decode_recursive(T, [H|Acc]);
decode_recursive(Chars, Acc) ->
    {Num, RestAfterNum} = parse_number(Chars),
    case RestAfterNum of
        [$|[T2]] ->
            {InnerDecoded, [$]|T3]} = decode_recursive(T2),
            RepeatedInner = repeat_string(InnerDecoded, Num),
            NewAcc = lists:foldl(fun(C, Acc0) -> [C|Acc0] end, Acc, RepeatedInner),
            decode_recursive(T3, NewAcc);
        _ ->
            error(badarg)
    end.