-module(generate_parenthesis).
-export([generate/1]).

generate(N) ->
    generate(N, 0, 0, []).

generate(_, _, N, Acc) when N == 0 ->
    lists:reverse(Acc);
generate(N, Open, Close, Acc) when Open < N ->
    generate(N, Open + 1, Close, [lists:flatten(["(", ""]) | Acc]);
generate(N, Open, Close, Acc) when Close < Open ->
    generate(N, Open, Close + 1, [lists:flatten([")", ""]) | Acc]);
generate(N, Open, Close, Acc) ->
    generate(N, Open, Close, Acc).