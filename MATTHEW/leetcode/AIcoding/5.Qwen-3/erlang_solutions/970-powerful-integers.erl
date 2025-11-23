-module(powerful_integers).
-export([powerful_integers/3]).

powerful_integers(X, Y, Z) ->
    Set = sets:new(),
    MaxX = floor(math:log(Z, X)) + 1,
    MaxY = floor(math:log(Z, Y)) + 1,
    lists:foldl(fun(I, Acc) ->
                        lists:foldl(fun(J, Acc2) ->
                                            Val = math:pow(X, I) + math:pow(Y, J),
                                            if Val =< Z -> sets:add_element(Val, Acc2);
                                               true -> Acc2
                                            end
                                    end, Acc, lists:seq(0, MaxY))
                end, Set, lists:seq(0, MaxX)),
    sets:to_list(Set).