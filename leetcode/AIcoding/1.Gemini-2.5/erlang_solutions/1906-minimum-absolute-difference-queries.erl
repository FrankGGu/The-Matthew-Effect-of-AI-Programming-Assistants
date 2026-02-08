-module(solution).
-export([min_absolute_difference_queries/2]).

list_to_array(L) ->
    array:from_list(L).

min_absolute_difference_queries(Nums, Queries) ->
    N = length(Nums),
    Nums_arr = list_to_array(Nums), % Convert input list to array for efficient access
    Root = build_tree_with_N(Nums_arr, 0, N - 1), % Build the segment tree
    lists:map(fun([L, R]) ->
                      Mask = query_tree_with_N(Root, 0, N - 1, L, R), % Query the mask for the range
                      calculate_min_diff(Mask) % Calculate min difference from the mask
              end, Queries).

build_tree_with_N(Nums_arr, Start, End) when Start == End ->
    Val = array:get(Start, Nums_arr), % Get value from array
    #{mask => (1 bsl Val)}; % Leaf node: mask with only its value's bit set
build_tree_with_N(Nums_arr, Start, End) ->
    Mid = Start + (End - Start) div 2,
    LeftChild = build_tree_with_N(Nums_arr, Start, Mid),
    RightChild = build_tree_with_N(Nums_arr, Mid + 1, End),
    Mask = maps:get(mask, LeftChild) bor maps:get(mask, RightChild), % Combine masks from children
    #{mask => Mask, left => LeftChild, right => RightChild}.

query_tree_with_N(Node, NodeStart, NodeEnd, QueryL, QueryR) when QueryL =< NodeStart, NodeEnd =< QueryR ->
    % Current node's range is fully contained within the query range
    maps:get(mask, Node);
query_tree_with_N(Node, NodeStart, NodeEnd, QueryL, QueryR) when QueryR < NodeStart; NodeEnd < QueryL ->
    % Current node's range is outside the query range
    0; % Return an empty mask
query_tree_with_N(Node, NodeStart, NodeEnd, QueryL, QueryR) ->
    % Current node's range partially overlaps the query range, recurse
    Mid = NodeStart + (NodeEnd - NodeStart) div 2,
    LeftMask = query_tree_with_N(maps:get(left, Node), NodeStart, Mid, QueryL, QueryR),
    RightMask = query_tree_with_N(maps:get(right, Node), Mid + 1, NodeEnd, QueryL, QueryR),
    LeftMask bor RightMask. % Combine masks from children's queries

calculate_min_diff(Mask) ->
    calculate_min_diff(Mask, 1, -1, 101). % Start checking from value 1, no last_seen yet, max possible diff is 100 (100-1), so 101 is initial infinity.

calculate_min_diff(Mask, Val, LastSeen, MinDiff) when Val > 100 ->
    % All possible values (1 to 100) have been checked
    case MinDiff of
        101 -> -1; % No two distinct elements found
        _ -> MinDiff
    end;
calculate_min_diff(Mask, Val, LastSeen, MinDiff) ->
    IsPresent = (Mask bsr Val) band 1, % Check if 'Val' is present in the mask
    case IsPresent of
        1 -> % If 'Val' is present
            case LastSeen of
                -1 -> % First distinct value found
                    calculate_min_diff(Mask, Val + 1, Val, MinDiff);
                _ -> % Another distinct value found, calculate difference
                    NewMinDiff = min(MinDiff, Val - LastSeen),
                    calculate_min_diff(Mask, Val + 1, Val, NewMinDiff)
            end;
        0 -> % If 'Val' is not present
            calculate_min_diff(Mask, Val + 1, LastSeen, MinDiff)
    end.