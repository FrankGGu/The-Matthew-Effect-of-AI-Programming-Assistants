-module(solution).
-export([find_gcd/2, replace_non_coprime/1]).

find_gcd(A, B) when B =:= 0 -> A;
find_gcd(A, B) -> find_gcd(B, A rem B).

replace_non_coprime(List) ->
    replace_non_coprime(List, []).

replace_non_coprime([], Acc) -> lists:reverse(Acc);
replace_non_coprime([H|T], Acc) ->
    case T of
        [] -> replace_non_coprime([], [H | Acc]);
        _ -> 
            Gcd = find_gcd(H, hd(T)),
            if
                Gcd > 1 -> replace_non_coprime(T, [Gcd | Acc]);
                true -> replace_non_coprime(T, [H | Acc])
            end
    end.