-module(solution).
-export([colorTheArray/2]).

colorTheArray(N, Queries) ->
    % Initial state: N elements, all with default color 0.
    % A color of 0 indicates an "uncolored" state and does not contribute to same-color pairs.
    InitialColors = array:new(N, {default, 0}),
    InitialSameColorPairs = 0,
    process_queries(N, Queries, InitialColors, InitialSameColorPairs, []).

process_queries(_N, [], _Colors, _CurrentSameColorPairs, Acc) ->
    lists:reverse(Acc);
process_queries(N, [[Index, NewColor] | RestQueries], Colors, CurrentSameColorPairs, Acc) ->
    OldColor = array:get(Index, Colors),

    NewColors = array:set(Index, NewColor, Colors),

    % If the color is not actually changing, the count remains the same.
    % This optimization prevents unnecessary delta calculations.
    NewSameColorPairs = if OldColor == NewColor ->
                            CurrentSameColorPairs
                        else
                            Delta = 0,

                            % Check left neighbor (Index - 1)
                            Delta1 = if Index > 0 ->
                                         LeftColor = array:get(Index - 1, Colors),
                                         D1 = if LeftColor == OldColor andalso OldColor /= 0 -> -1; else 0 end, % Lost a pair
                                         D2 = if LeftColor == NewColor andalso NewColor /= 0 -> 1; else 0 end, % Gained a pair
                                         D1 + D2
                                     else
                                         0
                                     end,

                            % Check right neighbor (Index + 1)
                            Delta2 = if Index < N - 1 ->
                                         RightColor = array:get(Index + 1, Colors),
                                         D1 = if OldColor == RightColor andalso OldColor /= 0 -> -1; else 0 end, % Lost a pair
                                         D2 = if NewColor == RightColor andalso NewColor /= 0 -> 1; else 0 end, % Gained a pair
                                         D1 + D2
                                     else
                                         0
                                     end,

                            CurrentSameColorPairs + Delta1 + Delta2
                        end,

    process_queries(N, RestQueries, NewColors, NewSameColorPairs, [NewSameColorPairs | Acc]).