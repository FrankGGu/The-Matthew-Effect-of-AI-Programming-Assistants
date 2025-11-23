-module(koko_eating_bananas).
-export([koko_has_eaten/1]).

koko_has_eaten(Piles) ->
    koko_has_eaten(Piles, 1, lists:max(Piles)).

koko_has_eaten(Piles, Low, High) ->
    case Low of
        High -> Low;
        _ ->
            Mid = (Low + High) div 2,
            if
                can_eat(Piles, Mid) -> koko_has_eaten(Piles, Low, Mid);
                true -> koko_has_eaten(Piles, Mid + 1, High)
            end
    end.

can_eat([], _K) ->
    true;
can_eat([Pile | Piles], K) ->
    Time = ceil(Pile / K),
    if
        Time =< 8 -> can_eat(Piles, K);
        true -> false
    end.

ceil(X) when X =< 0 -> 0;
ceil(X) -> trunc(X + 0.9999999999).