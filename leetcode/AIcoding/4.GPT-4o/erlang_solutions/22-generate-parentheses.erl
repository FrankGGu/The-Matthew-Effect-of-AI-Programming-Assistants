-spec generate_parenthesis(N :: integer()) -> [unicode:unicode_binary()].
generate_parenthesis(N) ->
    generate_parenthesis(N, N, []).

generate_parenthesis(0, 0, Acc) -> lists:reverse(Acc);
generate_parenthesis(Open, Close, Acc) when Open > 0 ->
    generate_parenthesis(Open - 1, Close, generate_parenthesis_helper(Open, Close, "(", Acc));
generate_parenthesis(Open, Close, Acc) when Close > Open ->
    generate_parenthesis(Open, Close - 1, generate_parenthesis_helper(Open, Close, ")", Acc)).

generate_parenthesis_helper(_, _, _, Acc) -> Acc.
generate_parenthesis_helper(Open, Close, Char, Acc) when Char == "(" ->
    generate_parenthesis_helper(Open - 1, Close, "(", [Char | Acc]);
generate_parenthesis_helper(Open, Close, Char, Acc) when Char == ")" ->
    generate_parenthesis_helper(Open, Close - 1, ")", [Char | Acc]).
