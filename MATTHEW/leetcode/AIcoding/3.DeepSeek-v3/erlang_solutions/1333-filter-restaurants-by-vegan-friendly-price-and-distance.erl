-spec filter_restaurants(Restaurants :: [[integer()]], VeganFriendly :: integer(), MaxPrice :: integer(), MaxDistance :: integer()) -> [integer()].
filter_restaurants(Restaurants, VeganFriendly, MaxPrice, MaxDistance) ->
    Filtered = lists:filter(fun([_, _, VF, P, D]) ->
                                (VeganFriendly =:= 0 orelse VF =:= VeganFriendly) andalso
                                P =< MaxPrice andalso
                                D =< MaxDistance
                            end, Restaurants),
    Sorted = lists:sort(fun([I1, R1, _, _, _], [I2, R2, _, _, _]) ->
                            if R1 =:= R2 -> I1 > I2;
                               true -> R1 > R2
                            end
                         end, Filtered),
    lists:map(fun([Id, _, _, _, _]) -> Id end, Sorted).