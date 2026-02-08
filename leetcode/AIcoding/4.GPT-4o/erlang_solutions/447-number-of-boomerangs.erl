-module(solution).
-export([number_of_boomerangs/1]).

%% Calculate the number of boomerangs given a list of points
-spec number_of_boomerangs([[integer()]]) -> integer().
number_of_boomerangs(Points) ->
    %% Initialize the result counter
    Result = lists:foldl(fun(Point, Acc) ->
                              %% For each point, calculate distances to all other points
                              Distances = calculate_distances(Point, Points),
                              %% Count pairs with the same distance
                              Acc + count_boomerangs(Distances)
                          end, 0, Points),
    Result.

%% Calculate the distances from a point to all other points
-spec calculate_distances([integer()],[[[integer()]]]) -> [integer()].
calculate_distances(_, []) -> [];
calculate_distances([X1, Y1], [[X2, Y2] | Rest]) ->
    Distance = (X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2),
    [Distance | calculate_distances([X1, Y1], Rest)].

%% Count the number of valid boomerangs for a given set of distances
-spec count_boomerangs([integer()]) -> integer().
count_boomerangs(Distances) ->
    %% Group distances and count combinations that form boomerangs
    DistanceCounts = count_occurrences(Distances, #{ }),
    lists:foldl(fun({_Distance, Count}, Acc) -> 
                    Acc + Count * (Count - 1)
                 end, 0, DistanceCounts).

%% Count occurrences of each distance in the list
-spec count_occurrences([integer()], map()) -> map().
count_occurrences([], Acc) -> Acc;
count_occurrences([H | T], Acc) ->
    NewAcc = case maps:find(H, Acc) of
                {ok, Count} -> maps:put(H, Count + 1, Acc);
                error -> maps:put(H, 1, Acc)
              end,
    count_occurrences(T, NewAcc).
