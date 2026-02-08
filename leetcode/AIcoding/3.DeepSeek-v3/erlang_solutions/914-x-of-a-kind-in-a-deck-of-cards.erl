-spec has_groups_size_x(Deck :: [integer()]) -> boolean().
has_groups_size_x(Deck) ->
    Counts = lists:foldl(fun(Card, Acc) ->
                            maps:update_with(Card, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Deck),
    Values = maps:values(Counts),
    GCD = lists:foldl(fun(Num, Acc) -> gcd(Num, Acc) end, hd(Values), tl(Values)),
    GCD >= 2.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).