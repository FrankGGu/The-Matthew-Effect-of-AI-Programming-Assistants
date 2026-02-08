-module(solution).
-export([replace_non_coprime_numbers/1]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).

-spec replace_non_coprime_numbers(Nums :: [integer()]) -> [integer()].
replace_non_coprime_numbers(Nums) ->
    process(Nums, []).

process([], Acc) ->
    lists:reverse(Acc); % Reverse the accumulator to get the correct order
process([H | T], []) ->
    process(T, [H]); % If accumulator is empty, just push the first element
process([H | T], [AccH | AccT] = Acc) ->
    G = gcd(AccH, H),
    if
        G > 1 -> % AccH and H are non-coprime, replace them with their LCM
            L = lcm(AccH, H),
            % The new number L needs to be checked against the new top of the stack (AccT).
            % This is done by effectively putting L back into the 'current element' position
            % and continuing the process with the reduced stack AccT.
            process([L | T], AccT);
        true -> % AccH and H are coprime, push H onto the accumulator
            process(T, [H | Acc])
    end.