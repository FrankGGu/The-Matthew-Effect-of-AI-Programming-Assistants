-spec generate_parenthesis(N :: integer()) -> [unicode:unicode_binary()].
generate_parenthesis(N) ->
    generate(N, N, []).

generate(0, 0, Acc) ->
    [list_to_binary(lists:reverse(Acc))];
generate(Open, Close, Acc) when Open > 0, Open =< Close ->
    case Open =:= Close of
        true ->
            generate(Open - 1, Close, [$ ( | Acc]);
        false ->
            generate(Open - 1, Close, [$ ( | Acc]) ++ generate(Open, Close - 1, [$) | Acc])
    end;
generate(Open, Close, Acc) when Open =:= 0, Close > 0 ->
    generate(Open, Close - 1, [$) | Acc]).