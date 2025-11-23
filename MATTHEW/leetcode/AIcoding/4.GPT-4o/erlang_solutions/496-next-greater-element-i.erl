-module(solution).
-export([next_greater_element/2]).

%% Finds the next greater element for each element in Nums1 based on Nums2.
-spec next_greater_element([integer()], [integer()]) -> [integer()].
next_greater_element(Nums1, Nums2) ->
    %% Initialize an empty stack and a map to store the next greater elements.
    process_stack(Nums2, [], maps:new())
    |> fun(Map) -> 
        [maps:get(Num, Map, -1) || Num <- Nums1] 
    end.

%% Processes the stack and the map to compute next greater elements.
-spec process_stack([integer()], [integer()], maps:map()) -> maps:map().
process_stack([], _, Map) -> Map;
process_stack([H | T], Stack, Map) ->
    case Stack of
        [] -> 
            process_stack(T, [H | Stack], Map);
        [Top | _] when H > Top ->
            NewMap = maps:put(Top, H, Map),
            NewStack = lists:delete(Top, Stack),
            process_stack([H | T], NewStack, NewMap);
        _ ->
            process_stack(T, [H | Stack], Map)
    end.
