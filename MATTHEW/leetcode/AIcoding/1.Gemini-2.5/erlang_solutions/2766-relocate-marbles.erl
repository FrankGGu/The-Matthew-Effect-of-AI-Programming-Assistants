-module(solution).
-export([relocate_marbles/3]).

relocate_marbles(Marbles, MoveFrom, MoveTo) ->
    % 1. Convert the initial list of marble positions into a gb_set for efficient lookups and modifications.
    %    gb_sets automatically handles uniqueness and keeps elements sorted for to_list/1.
    InitialSet = gb_sets:from_list(Marbles),

    % 2. Pair up moveFrom and moveTo positions into a list of {From, To} tuples.
    Moves = lists:zip(MoveFrom, MoveTo),

    % 3. Iterate through the moves, updating the set of marble positions.
    FinalSet = lists:foldl(
        fun({From, To}, CurrentSet) ->
            % Check if there is a marble at the 'From' position.
            case gb_sets:is_member(From, CurrentSet) of
                true ->
                    % If a marble exists at 'From', remove it and add 'To'.
                    % gb_sets:del_element/2 removes 'From'.
                    % gb_sets:add/2 adds 'To'. If 'To' already exists, it's a no-op, maintaining uniqueness.
                    gb_sets:add(To, gb_sets:del_element(From, CurrentSet));
                false ->
                    % If no marble exists at 'From', do nothing for this move.
                    CurrentSet
            end
        end,
        InitialSet,
        Moves
    ),

    % 4. Convert the final set of unique marble positions back to a sorted list.
    gb_sets:to_list(FinalSet).