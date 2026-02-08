-module(solution).
-export([number_of_weak_characters/1]).

number_of_weak_characters(Players) ->
    PlayersSorted = lists:sort(fun(A, B) -> 
        if 
            hd(A) == hd(B) -> hd(tl(A)) < hd(tl(B));
            true -> hd(A) < hd(B)
        end
    end, Players),
    Weak = 0,
    MaxDef = 0,
    number_of_weak_characters(PlayersSorted, Weak, MaxDef).

number_of_weak_characters([], Weak, _) -> Weak;
number_of_weak_characters([Player | Rest], Weak, MaxDef) ->
    [Attack, Defense] = Player,
    if 
        Defense < MaxDef -> 
            number_of_weak_characters(Rest, Weak + 1, MaxDef);
        true -> 
            number_of_weak_characters(Rest, Weak, Defense)
    end.