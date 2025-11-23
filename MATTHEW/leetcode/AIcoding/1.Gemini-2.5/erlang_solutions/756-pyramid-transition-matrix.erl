-module(solution).
-export([pyramidTransition/2]).

pyramidTransition(Bottom, Allowed) ->
    % Build an AllowedMap for efficient lookup of possible top characters.
    % Key: {Char1, Char2} (tuple of two characters)
    % Value: List of characters that can be formed by Char1 and Char2
    AllowedMap = lists:foldl(
        fun([C1, C2, C3], Acc) -> % Pattern match on list of characters for each allowed rule
            Key = {C1, C2},
            % Update the map: if key exists, prepend C3 to its list; otherwise, create a new list [C3].
            maps:update_with(Key, fun(Val) -> [C3 | Val] end, [C3], Acc)
        end,
        #{}, % Initial empty map
        Allowed
    ),

    % Start the recursive search with memoization.
    % `can_build_memo` returns {BooleanResult, UpdatedMemoMap}.
    % We only need the boolean result.
    {Result, _FinalMemo} = can_build_memo(Bottom, AllowedMap, #{}),
    Result.

can_build_memo(Layer, AllowedMap, Memo) ->
    case maps:find(Layer, Memo) of
        {ok, Res} -> % If the result for this layer is already computed, return it directly.
            {Res, Memo};
        _ -> % If not computed, proceed with the calculation.
            Result = 
                if length(Layer) == 1 -> % Base case: If the layer has only one block, the pyramid is successfully built.
                    true;
                true -> % Recursive step: Try to build the next layer (one level up).
                    PossibleNextBlocks = get_possible_blocks_for_next_layer(Layer, AllowedMap),
                    if PossibleNextBlocks == [] -> % If no blocks can be formed for the next layer, this path is impossible.
                        false;
                    true ->
                        % Generate all possible combinations for the next layer from the `PossibleNextBlocks`.
                        AllNextLayers = generate_all_combinations(PossibleNextBlocks),
                        % Recursively check if any of these next layers can lead to a complete pyramid.
                        % `check_next_layers` will also update the memo map.
                        check_next_layers(AllNextLayers, AllowedMap, Memo)
                    end
                end,
            % Store the computed result for the current layer in the memo map and return it.
            {Result, maps:put(Layer, Result, Memo)}
    end.

get_possible_blocks_for_next_layer([C1, C2 | Rest], AllowedMap) ->
    PossibleChars = maps:get({C1, C2}, AllowedMap, []), % Get characters that can be formed by C1 and C2.
    if PossibleChars == [] ->
        []; % If no char can be formed for this pair, then no next layer can be formed from this path.
       true ->
        case Rest of
            [] -> % Base case: This is the last pair in the current layer.
                [PossibleChars];
            _ ->
                % Recursively get possible blocks for the rest of the layer.
                case get_possible_blocks_for_next_layer([C2 | Rest], AllowedMap) of
                    [] -> []; % If the rest of the layer cannot form valid blocks, then the entire next layer cannot be formed.
                    RestPossible -> [PossibleChars | RestPossible] % Combine results.
                end
        end
    end;
get_possible_blocks_for_next_layer([_], _AllowedMap) ->
    []; % A layer of length 1 has no pairs to form the next layer. This function should not be called for a layer of length 1 as it's a base case for `can_build_memo`.
get_possible_blocks_for_next_layer([], _AllowedMap) ->
    []. % An empty layer has no pairs.

generate_all_combinations([]) ->
    [[]]; % Base case: one combination, the empty list.
generate_all_combinations([H | T]) ->
    RestCombinations = generate_all_combinations(T), % Recursively get combinations for the tail.
    % For each element X in the head list H, combine it with each combination Y from RestCombinations.
    [ [X | Y] || X <- H, Y <- RestCombinations ].

check_next_layers([], _AllowedMap, Memo) ->
    {false, Memo}; % No more next layers to try, and none succeeded. Return false.
check_next_layers([NextLayer | Rest], AllowedMap, Memo) ->
    % Recursively check if the current `NextLayer` can lead to a complete pyramid.
    {SubResult, Memo1} = can_build_memo(NextLayer, AllowedMap, Memo),
    if SubResult == true ->
        {true, Memo1}; % If this path works, we found a solution. Return true immediately with the updated memo.
    true ->
        % This path didn't work. Try the next `NextLayer` in the list, passing the updated memo.
        check_next_layers(Rest, AllowedMap, Memo1)
    end.