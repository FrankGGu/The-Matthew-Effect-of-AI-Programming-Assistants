-module(mountain_array).
-export([get/2, length/1]).

-spec get(Index :: integer(), MountainArray :: term()) -> integer().
get(_, _) -> 0.

-spec length(MountainArray :: term()) -> integer().
length(_) -> 0.

-module(solution).
-export([find_in_mountain_array/2]).

find_in_mountain_array(Target, MountainArray) ->
    N = mountain_array:length(MountainArray),
    Peak = find_peak(1, N - 2, MountainArray),
    case binary_search_left(0, Peak, Target, MountainArray) of
        {found, Index} -> Index;
        not_found ->
            case binary_search_right(Peak + 1, N - 1, Target, MountainArray) of
                {found, Index} -> Index;
                not_found -> -1
            end
    end.

find_peak(Left, Right, MountainArray) ->
    case Left > Right of
        true -> -1;
        false ->
            Mid = Left + (Right - Left) div 2,
            MidVal = mountain_array:get(Mid, MountainArray),
            NextVal = mountain_array:get(Mid + 1, MountainArray),
            if
                MidVal < NextVal -> find_peak(Mid + 1, Right, MountainArray);
                MidVal > NextVal -> find_peak(Left, Mid - 1, MountainArray);
                true -> Mid
            end
    end.

binary_search_left(Left, Right, Target, MountainArray) ->
    case Left > Right of
        true -> not_found;
        false ->
            Mid = Left + (Right - Left) div 2,
            MidVal = mountain_array:get(Mid, MountainArray),
            if
                MidVal =:= Target -> {found, Mid};
                MidVal < Target -> binary_search_left(Mid + 1, Right, Target, MountainArray);
                true -> binary_search_left(Left, Mid - 1, Target, MountainArray)
            end
    end.

binary_search_right(Left, Right, Target, MountainArray) ->
    case Left > Right of
        true -> not_found;
        false ->
            Mid = Left + (Right - Left) div 2,
            MidVal = mountain_array:get(Mid, MountainArray),
            if
                MidVal =:= Target -> {found, Mid};
                MidVal > Target -> binary_search_right(Mid + 1, Right, Target, MountainArray);
                true -> binary_search_right(Left, Mid - 1, Target, MountainArray)
            end
    end.