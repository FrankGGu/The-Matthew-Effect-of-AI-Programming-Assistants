-module(solution).
-export([num_burgers/3]).

num_burgers(egg_total, tomato_total, burger_total) ->
    num_burgers(egg_total, tomato_total, burger_total, 0).

num_burgers(EggTotal, TomatoTotal, BurgerTotal, Acc) ->
    case Acc of
        N when N > BurgerTotal -> [];
        _ ->
            Egg = Acc * 2,
            Tomato = Acc * 3,
            if
                Egg + Tomato == BurgerTotal andalso EggTotal >= Egg andalso TomatoTotal >= Tomato ->
                    [Acc];
                true ->
                    num_burgers(EggTotal, TomatoTotal, BurgerTotal, Acc + 1)
            end
    end.