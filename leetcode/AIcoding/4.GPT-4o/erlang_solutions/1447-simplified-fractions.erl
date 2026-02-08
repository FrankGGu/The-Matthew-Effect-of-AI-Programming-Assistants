-module(solution).
-export([simplifiedFractions/1]).

simplifiedFractions(N) ->
    lists:map(fun({Num, Den}) -> integer_to_list(Num) ++ "/" ++ integer_to_list(Den) end,
        lists:filter(fun({Num, Den}) -> gcd(Num, Den) =:= 1 end,
            [{Num, Den} || Num <- lists:seq(1, N-1), Den <- lists:seq(Num+1, N)])).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).