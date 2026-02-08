-module(solution).
-export([boats_to_save_people/2]).

boats_to_save_people(People, Limit) ->
    SortedPeople = lists:sort(People),
    Arr = array:from_list(SortedPeople),
    N = array:size(Arr),
    save_helper(Arr, 0, N - 1, Limit, 0).

save_helper(Arr, LeftIdx, RightIdx, Limit, Boats) ->
    if
        LeftIdx > RightIdx ->
            Boats;
        true ->
            NewBoats = Boats + 1,
            L = array:get(LeftIdx, Arr),
            R = array:get(RightIdx, Arr),
            if
                L + R =< Limit ->
                    save_helper(Arr, LeftIdx + 1, RightIdx - 1, Limit, NewBoats);
                true -> % L + R > Limit
                    save_helper(Arr, LeftIdx, RightIdx - 1, Limit, NewBoats)
            end
    end.