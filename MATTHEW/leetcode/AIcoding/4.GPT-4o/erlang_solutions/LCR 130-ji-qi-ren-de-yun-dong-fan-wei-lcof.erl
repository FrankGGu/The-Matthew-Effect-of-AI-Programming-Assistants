-module(solution).
-export([organize_closet/2]).

organize_closet(Clothes, Target) ->
    lists:foldl(fun({Type, Count}, Acc) ->
        case lists:keyfind(Type, 1, Acc) of
            false -> [{Type, Count} | Acc];
            {Type, ExistingCount} -> lists:keyreplace(Type, 1, Acc, {Type, ExistingCount + Count})
        end
    end, [], Clothes).