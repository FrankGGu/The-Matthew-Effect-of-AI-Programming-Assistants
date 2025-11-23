-spec find_right_interval(Intervals :: [[integer()]]) -> [integer()].
find_right_interval(Intervals) ->
    %% Attach original indices to intervals
    Indexed = lists:zip(Intervals, lists:seq(0, length(Intervals)-1)),
    %% Sort by start value
    Sorted = lists:keysort(1, lists:map(fun({[Start, End], Index}) -> {Start, End, Index} end, Indexed)),

    %% Extract starts and their original indices
    Starts = [Start || {Start, _, _} <- Sorted],
    IndexMap = [{Start, Index} || {Start, _, Index} <- Sorted],

    %% For each interval in original order, find the minimal start >= end using binary search
    lists:map(
      fun({_Start, End, OrigIndex}) ->
          case binary_search(Starts, End) of
            -1 -> -1;
            Pos -> 
              {_, Index} = lists:nth(Pos + 1, IndexMap),
              Index
          end
      end, Sorted).

%% binary_search to find the minimal index with value >= Target in a sorted list
-spec binary_search([integer()], integer()) -> integer().
binary_search(List, Target) -> binary_search(List, Target, 0, length(List)-1).

binary_search(_, _Target, Low, High) when Low > High -> -1;
binary_search(List, Target, Low, High) ->
    Mid = (Low + High) div 2,
    Elem = lists:nth(Mid + 1, List),
    if
        Elem >= Target ->
            case binary_search(List, Target, Low, Mid - 1) of
                -1 -> Mid;
                Pos -> Pos
            end;
        true ->
            binary_search(List, Target, Mid + 1, High)
    end.
