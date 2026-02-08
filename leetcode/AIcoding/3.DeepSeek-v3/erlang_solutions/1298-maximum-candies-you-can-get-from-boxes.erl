-module(solution).
-export([max_candies/4]).

max_candies(Status, Candies, Keys, ContainedBoxes) ->
    N = length(Status),
    Visited = array:new(N, {default, false}),
    Queue = queue:new(),
    InitialBoxes = [I || {I, S} <- lists:zip(lists:seq(0, N-1), Status), S =:= 1],
    Queue1 = lists:foldl(fun(Box, Q) -> queue:in(Box, Q) end, Queue, InitialBoxes),
    {Total, _, _} = bfs(Queue1, Visited, array:from_list(Candies), array:from_list(Keys), array:from_list(ContainedBoxes), 0),
    Total.

bfs(Queue, Visited, Candies, Keys, ContainedBoxes, Total) ->
    case queue:out(Queue) of
        {empty, _} -> {Total, Visited, Keys};
        {{value, Box}, Queue1} ->
            case array:get(Box, Visited) of
                true -> bfs(Queue1, Visited, Candies, Keys, ContainedBoxes, Total);
                false ->
                    Visited1 = array:set(Box, true, Visited),
                    Total1 = Total + array:get(Box, Candies),
                    NewKeys = array:get(Box, Keys),
                    Keys1 = lists:foldl(fun(Key, Ks) -> 
                        case array:get(Key, Ks) of
                            0 -> array:set(Key, 1, Ks);
                            _ -> Ks
                        end
                    end, Keys, NewKeys),
                    NewBoxes = array:get(Box, ContainedBoxes),
                    Queue2 = lists:foldl(fun(B, Q) -> 
                        case array:get(B, Visited1) of
                            false -> 
                                case array:get(B, Keys1) > 0 orelse lists:member(B, InitialBoxes) of
                                    true -> queue:in(B, Q);
                                    false -> Q
                                end;
                            true -> Q
                        end
                    end, Queue1, NewBoxes),
                    bfs(Queue2, Visited1, Candies, Keys1, ContainedBoxes, Total1)
            end
    end.