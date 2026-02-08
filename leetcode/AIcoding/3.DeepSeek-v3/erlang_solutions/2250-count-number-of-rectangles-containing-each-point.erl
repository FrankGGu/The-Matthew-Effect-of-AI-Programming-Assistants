-spec count_rectangles(Rectangles :: [[integer()]], Points :: [[integer()]]) -> [integer()].
count_rectangles(Rectangles, Points) ->
    % Preprocess rectangles by grouping them by their y-coordinate
    YMap = lists:foldl(fun([X, Y], Acc) ->
                           maps:update_with(Y, fun(List) -> [X | List] end, [X], Acc)
                       end, #{}, Rectangles),
    % Sort the keys (y-coordinates) in descending order
    SortedYs = lists:sort(fun(A, B) -> A >= B end, maps:keys(YMap)),
    % For each y-coordinate, sort the x-coordinates
    ProcessedYMap = maps:map(fun(_Y, Xs) -> lists:sort(Xs) end, YMap),
    % Process each point
    lists:map(fun([X, Y]) ->
                  count_for_point(ProcessedYMap, SortedYs, X, Y)
              end, Points).

count_for_point(YMap, SortedYs, X, Y) ->
    lists:foldl(fun(CurrentY, Acc) ->
                    case CurrentY >= Y of
                        true ->
                            case maps:get(CurrentY, YMap, []) of
                                [] -> Acc;
                                Xs ->
                                    % Find the first X in Xs >= point's X
                                    case find_first_gte(Xs, X) of
                                        not_found -> Acc;
                                        Index -> Acc + length(Xs) - Index
                                    end
                            end;
                        false -> Acc
                    end
                end, 0, SortedYs).

find_first_gte(Xs, X) ->
    find_first_gte(Xs, X, 0, length(Xs) - 1).

find_first_gte(Xs, X, Low, High) when Low =< High ->
    Mid = (Low + High) div 2,
    MidX = lists:nth(Mid + 1, Xs),
    if
        MidX >= X ->
            case Mid =:= Low orelse lists:nth(Mid, Xs) < X of
                true -> Mid;
                false -> find_first_gte(Xs, X, Low, Mid - 1)
            end;
        true -> find_first_gte(Xs, X, Mid + 1, High)
    end;
find_first_gte(_Xs, _X, _Low, _High) ->
    not_found.