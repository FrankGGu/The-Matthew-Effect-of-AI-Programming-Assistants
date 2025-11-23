-module(solution).
-export([twoSum/2]).

twoSum(Nums, Target) ->
    find_pair(Nums, Target, 0, maps:new()).

find_pair([H | T], Target, Index, SeenMap) ->
    Complement = Target - H,
    case maps:find(Complement, SeenMap) of
        {ok, PrevIndex} ->
            [PrevIndex, Index];
        _ ->
            NewSeenMap = maps:put(H, Index, SeenMap),
            find_pair(T, Target, Index + 1, NewSeenMap)
    end;
find_pair([], _, _, _) ->
    [].