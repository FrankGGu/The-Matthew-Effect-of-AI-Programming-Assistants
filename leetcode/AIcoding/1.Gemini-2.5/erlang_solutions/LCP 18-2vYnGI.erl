-module(solution).
-export([breakfast_combination/3]).

-spec breakfast_combination(Staple :: [integer()], Drinks :: [integer()], X :: integer()) -> integer().
breakfast_combination(Staple, Drinks, X) ->
    SortedStaple = lists:sort(Staple),
    SortedDrinks = lists:sort(Drinks),

    DrinksArray = array:from_list(SortedDrinks),
    DrinksLen = array:size(DrinksArray),

    Mod = 1000000007,

    solve(SortedStaple, DrinksArray, X, DrinksLen - 1, 0, Mod).

solve([], _DrinksArray, _X, _DrinksIdx, Acc, _Mod) ->
    Acc;

solve([S | RestStaple], DrinksArray, X, DrinksIdx, Acc, Mod) ->
    NewDrinksIdx = find_max_drink_idx(S, DrinksArray, X, DrinksIdx),

    NewAcc = if 
                 NewDrinksIdx >= 0 ->
                     (Acc + NewDrinksIdx + 1) rem Mod;
                 true ->
                     Acc
             end,

    solve(RestStaple, DrinksArray, X, NewDrinksIdx, NewAcc, Mod).

find_max_drink_idx(_S, _DrinksArray, _X, DrinksIdx) when DrinksIdx < 0 ->
    -1;

find_max_drink_idx(S, DrinksArray, X, CurrentDrinksIdx) ->
    DrinkPrice = array:get(CurrentDrinksIdx, DrinksArray),
    if
        S + DrinkPrice > X ->
            find_max_drink_idx(S, DrinksArray, X, CurrentDrinksIdx - 1);
        true ->
            CurrentDrinksIdx
    end.