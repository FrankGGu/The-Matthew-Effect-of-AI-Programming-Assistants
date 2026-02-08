-module(solution).
-export([closest_room/2]).

abs_diff(A, B) ->
    abs(A - B).

closest_room(Rooms, Queries) ->
    NumQueries = length(Queries),

    % Add original index to queries: [{Preferred, MinSize, OriginalIdx}]
    IndexedQueries = lists:map(fun([Preferred, MinSize], Idx) ->
                                       {Preferred, MinSize, Idx}
                               end, Queries, lists:seq(0, NumQueries - 1)),

    % Sort queries by minSize in descending order
    SortedQueries = lists:sort(fun({_P1, MinSize1, _Idx1}, {_P2, MinSize2, _Idx2}) ->
                                      MinSize1 >= MinSize2
                              end, IndexedQueries),

    % Sort rooms by size in descending order
    SortedRooms = lists:sort(fun([_Id1, Size1], [_Id2, Size2]) ->
                                    Size1 >= Size2
                            end, Rooms),

    % Initialize an array for answers, filled with -1
    AnswerArray = array:new(NumQueries, {default, -1}),

    % Call the recursive helper function
    solve(SortedRooms, SortedQueries, gb_trees:empty(), AnswerArray).

solve(_RemainingRooms, [], _RoomIdTree, AnswerArray) ->
    array:to_list(AnswerArray);

solve(RemainingRooms, [{Preferred, MinSize, OriginalIdx} | RestQueries], RoomIdTree, AnswerArray) ->
    % Add eligible rooms from RemainingRooms to the tree
    % and get the new list of remaining rooms and updated tree
    {NewRemainingRooms, UpdatedRoomIdTree} = add_eligible_rooms(RemainingRooms, MinSize, RoomIdTree),

    CurrentAnswer = 
        case gb_trees:is_empty(UpdatedRoomIdTree) of
            true ->
                -1;
            false ->
                % Find closest room ID
                FloorResult = gb_trees:lookup_le(Preferred, UpdatedRoomIdTree),
                CeilingResult = gb_trees:lookup_ge(Preferred, UpdatedRoomIdTree),

                case {FloorResult, CeilingResult} of
                    {none, none} -> % Should not happen if tree is not empty
                        -1; 
                    {{value, FloorRoomId, _}, none} ->
                        FloorRoomId;
                    {none, {value, CeilingRoomId, _}} ->
                        CeilingRoomId;
                    {{value, FloorRoomId, _}, {value, CeilingRoomId, _}} ->
                        DistFloor = abs_diff(FloorRoomId, Preferred),
                        DistCeiling = abs_diff(CeilingRoomId, Preferred),

                        if 
                            DistFloor =< DistCeiling -> FloorRoomId; % Tie-breaking: choose smaller RoomId
                            true -> CeilingRoomId
                        end
                end
        end,

    % Update the answer array
    NewAnswerArray = array:set(OriginalIdx, CurrentAnswer, AnswerArray),

    % Recurse for the next query
    solve(NewRemainingRooms, RestQueries, UpdatedRoomIdTree, NewAnswerArray).

add_eligible_rooms([], _MinSize, RoomIdTree) ->
    {[], RoomIdTree};
add_eligible_rooms([[RoomId, Size] | RestRooms], MinSize, RoomIdTree) ->
    if 
        Size >= MinSize ->
            NewRoomIdTree = gb_trees:insert(RoomId, true, RoomIdTree),
            add_eligible_rooms(RestRooms, MinSize, NewRoomIdTree);
        true ->
            % Rooms are sorted by size descending. If current room's size < MinSize,
            % all subsequent rooms will also have size < MinSize.
            % So, we stop and return the rest of the rooms.
            {[[RoomId, Size] | RestRooms], RoomIdTree}
    end.