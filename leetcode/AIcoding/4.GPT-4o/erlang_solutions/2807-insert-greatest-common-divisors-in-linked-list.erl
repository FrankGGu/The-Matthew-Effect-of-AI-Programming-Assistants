-module(solution).
-export([insert_gcd/1]).

-record(node, {val, next}).

insert_gcd(List) ->
    case List of
        [] -> [];
        [_] -> List;
        [H1, H2 | T] ->
            [H1 | [gcd(H1, H2) | insert_gcd([H2 | T])]]
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).