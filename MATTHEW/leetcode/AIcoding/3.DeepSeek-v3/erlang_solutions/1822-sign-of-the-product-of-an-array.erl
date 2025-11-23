-spec array_sign(Nums :: [integer()]) -> integer().
array_sign(Nums) ->
    array_sign(Nums, 1).

array_sign([], Sign) -> Sign;
array_sign([0 | _], _) -> 0;
array_sign([Num | Rest], Sign) when Num < 0 ->
    array_sign(Rest, -Sign);
array_sign([_ | Rest], Sign) ->
    array_sign(Rest, Sign).