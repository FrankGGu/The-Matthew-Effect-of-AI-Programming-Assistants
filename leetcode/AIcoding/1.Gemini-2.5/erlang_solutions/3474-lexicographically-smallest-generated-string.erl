-module(solution).
-export([generateTheString/1]).

generateTheString(N) ->
    generate_string_recursive(N, [], 0).

generate_string_recursive(N, Acc, Index) when Index == N ->
    lists:reverse(Acc);
generate_string_recursive(N, Acc, Index) ->
    Char = case Index rem 4 of
               0 -> $a;
               1 -> $a;
               2 -> $b;
               3 -> $b
           end,
    generate_string_recursive(N, [Char | Acc], Index + 1).