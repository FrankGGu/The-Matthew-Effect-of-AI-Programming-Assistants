-module(stone_game_iv).
-export([winner/1]).

winner(N) ->
    Max = N,
    DP = array:new(Max + 1, {default, false}),
    DP1 = array:set(0, true, DP),
    DP2 = array:set(1, true, DP1),
    loop(2, Max, DP2).

loop(I, Max, DP) when I > Max ->
    array:get(Max, DP);
loop(I, Max, DP) ->
    SqrtI = math:floor(math:sqrt(I)),
    J = 1,
    Found = find_square(J, SqrtI, I, DP),
    NewDP = array:set(I, Found, DP),
    loop(I + 1, Max, NewDP).

find_square(J, SqrtI, I, DP) when J > SqrtI ->
    false;
find_square(J, SqrtI, I, DP) ->
    Square = J * J,
    if
        Square > I ->
            false;
        true ->
            if
                array:get(I - Square, DP) == false ->
                    true;
                true ->
                    find_square(J + 1, SqrtI, I, DP)
            end
    end.