-module(solution).
-export([num_people_to_teach/3]).

num_people_to_teach(N, languages, friendships) ->
    Teachers = lists:foldl(fun ({X, Y}, Acc) ->
        case lists:member(X, Acc) orelse lists:member(Y, Acc) of
            true -> Acc;
            false -> lists:append(Acc, [X, Y])
        end
    end, [], friendships),
    UniqueLanguages = lists:foldl(fun (X, Acc) -> lists:append(Acc, lists:duplicate(1, X)) end, [], languages),
    Needed = lists:foldl(fun (Lang, Acc) -> 
        case lists:member(Lang, UniqueLanguages) of
            true -> Acc;
            false -> Acc + 1
        end
    end, 0, UniqueLanguages),
    max(Needed, length(Teachers)).