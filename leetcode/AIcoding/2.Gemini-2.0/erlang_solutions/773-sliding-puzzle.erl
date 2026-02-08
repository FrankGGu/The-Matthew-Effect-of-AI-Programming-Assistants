-module(sliding_puzzle).
-export([sliding_puzzle/1]).

sliding_puzzle(Board) ->
    Target = [1,2,3,4,5,0],
    InitialState = list_to_tuple(lists:flatten(Board)),
    TargetState = list_to_tuple(Target),
    Q = queue:new(),
    queue:in(InitialState, Q),
    Visited = sets:new(),
    sets:add_element(InitialState, Visited),
    BFS(Q, TargetState, Visited, 0).

BFS(Q, TargetState, Visited, Moves) ->
    case queue:is_empty(Q) of
        true -> -1;
        false ->
            {Value, NewQ} = queue:out(Q),
            case Value of
                TargetState -> Moves;
                _ ->
                    ZeroIndex = find_zero_index(tuple_to_list(Value)),
                    Neighbors = get_neighbors(Value, ZeroIndex),
                    {UpdatedQ, UpdatedVisited} = lists:foldl(
                        fun(Neighbor, {AccQ, AccVisited}) ->
                            case sets:is_element(Neighbor, AccVisited) of
                                true -> {AccQ, AccVisited};
                                false ->
                                    NewAccQ = queue:in(Neighbor, AccQ),
                                    NewAccVisited = sets:add_element(Neighbor, AccVisited),
                                    {NewAccQ, NewAccVisited}
                            end
                        end,
                        {NewQ, Visited},
                        Neighbors
                    ),
                    BFS(UpdatedQ, TargetState, UpdatedVisited, Moves + 1)
            end
    end.

find_zero_index(List) ->
    find_zero_index_helper(List, 0).

find_zero_index_helper([H|T], Index) ->
    case H of
        0 -> Index;
        _ -> find_zero_index_helper(T, Index + 1)
    end.

get_neighbors(State, ZeroIndex) ->
    Moves = case ZeroIndex of
        0 -> [1, 3];
        1 -> [0, 2, 4];
        2 -> [1, 5];
        3 -> [0, 4];
        4 -> [1, 3, 5];
        5 -> [2, 4]
    end,
    lists:map(fun(MoveIndex) -> swap(State, ZeroIndex, MoveIndex) end, Moves).

swap(State, Index1, Index2) ->
    List = tuple_to_list(State),
    Val1 = lists:nth(Index1 + 1, List),
    Val2 = lists:nth(Index2 + 1, List),
    NewList = lists:nthreplace(Index1 + 1, Val2, lists:nthreplace(Index2 + 1, Val1, List)),
    list_to_tuple(NewList).