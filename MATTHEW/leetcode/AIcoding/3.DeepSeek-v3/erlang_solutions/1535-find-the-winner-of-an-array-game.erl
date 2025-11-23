-spec get_winner(Arr :: [integer()], K :: integer()) -> integer().
get_winner(Arr, K) ->
    Max = lists:max(Arr),
    get_winner(Arr, K, 0, Max).

get_winner([H | T], K, Count, Max) when H == Max ->
    Max;
get_winner([H1, H2 | T], K, Count, Max) when H1 > H2 ->
    NewCount = Count + 1,
    if
        NewCount >= K -> H1;
        true -> get_winner([H1 | T], K, NewCount, Max)
    end;
get_winner([H1, H2 | T], K, _Count, Max) ->
    get_winner([H2, H1 | T], K, 1, Max).