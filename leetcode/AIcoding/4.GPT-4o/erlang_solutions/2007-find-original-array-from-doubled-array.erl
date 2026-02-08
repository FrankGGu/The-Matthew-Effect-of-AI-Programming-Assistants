-module(solution).
-export([find_original_array/1]).

find_original_array(DoubledArray) ->
    SortedArray = lists:sort(DoubledArray),
    find_original(SortedArray, [], 0).

find_original([], Original, _) -> 
    Original;
find_original([H | T], Original, Count) when H rem 2 =:= 0 ->
    case lists:member(H div 2, Original) of
        true -> 
            find_original(T, lists:delete(H div 2, Original), Count + 1);
        false -> 
            find_original(T, [H div 2 | Original], Count + 1)
    end;
find_original([_ | T], Original, Count) -> 
    find_original(T, Original, Count).