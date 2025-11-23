-module(solution).
-export([generate_parenthesis/1]).

generate_parenthesis(N) ->
    generate_parenthesis(N, N, "", []).

generate_parenthesis(0, 0, Current, Acc) ->
    [Current | Acc];
generate_parenthesis(Left, Right, Current, Acc) when Left > 0 ->
    generate_parenthesis(Left - 1, Right, Current ++ "(", Acc);
generate_parenthesis(Left, Right, Current, Acc) when Right > Left ->
    generate_parenthesis(Left, Right - 1, Current ++ ")", Acc).

generate_parenthesis(N) -> 
    generate_parenthesis(N, N, "", []).