-module(solution).
-export([min_penalty_for_shop/1]).

min_penalty_for_shop(Customers) ->
    N = length(Customers),
    LeftNCounts = calculate_left_n_counts(Customers),
    RightYCounts = calculate_right_y_counts(Customers),

    Penalties = lists:zipwith(fun(L, R) -> L + R end, LeftNCounts, RightYCounts),

    find_min_penalty_index(Penalties, 0, {hd(Penalties), 0}).

calculate_left_n_counts(Customers) ->
    calculate_left_n_counts(Customers, 0, [0]).

calculate_left_n_counts([], _CurrentN, Acc) ->
    lists:reverse(Acc);
calculate_left_n_counts([H|T], CurrentN, Acc) ->
    NewN = CurrentN + (if H == $N then 1 else 0),
    calculate_left_n_counts(T, NewN, [NewN | Acc]).

calculate_right_y_counts(Customers) ->
    calculate_right_y_counts(lists:reverse(Customers), 0, [0]).

calculate_right_y_counts([], _CurrentY, Acc) ->
    Acc;
calculate_right_y_counts([H|T], CurrentY, Acc) ->
    NewY = CurrentY + (if H == $Y then 1 else 0),
    calculate_right_y_counts(T, NewY, [NewY | Acc]).

find_min_penalty_index([H|T], CurrentIndex, {MinPenalty, MinIndex}) ->
    if
        H < MinPenalty ->
            find_min_penalty_index(T, CurrentIndex + 1, {H, CurrentIndex});
        true ->
            find_min_penalty_index(T, CurrentIndex + 1, {MinPenalty, MinIndex})
    end;
find_min_penalty_index([], _CurrentIndex, {_MinPenalty, MinIndex}) ->
    MinIndex.