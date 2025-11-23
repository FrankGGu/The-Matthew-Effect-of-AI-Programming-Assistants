-module(solution).
-export([is_coprime/1]).

is_coprime(Nums) ->
    N = length(Nums),
    case N of
        1 -> true;
        _ ->
            Left = lists:sublist(Nums, 1, N-1),
            Right = lists:sublist(Nums, N, 1),
            ProductLeft = product(Left),
            ProductRight = product(Right),
            gcd(ProductLeft, ProductRight) == 1
    end.

product([]) -> 1;
product([H|T]) -> H * product(T).

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).