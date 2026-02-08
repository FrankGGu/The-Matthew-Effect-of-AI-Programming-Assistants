-module(solution).
-export([queensAttacktheKing/2]).

queensAttacktheKing(Queens, King) ->
    KingR = hd(King),
    KingC = hd(tl(King)),

    QueenSet = gb_sets:from_list(lists:map(fun([R, C]) -> {R, C} end, Queens)),

    Directions = [
        {-1, 0}, {1, 0}, {0, -1}, {0, 1},   % Orthogonal: Up, Down, Left, Right
        {-1, -1}, {-1, 1}, {1, -1}, {1, 1}  % Diagonal: Up-Left, Up-Right, Down-Left, Down-Right
    ],

    lists:foldl(fun({DR, DC}, Acc) ->
        case find_closest_queen_in_direction(KingR + DR, KingC + DC, DR, DC, QueenSet) of
            {R, C} -> [[R, C] | Acc];
            none -> Acc
        end
    end, [], Directions).

find_closest_queen_in_direction(R, C, DR, DC, QueenSet) ->
    if 
        R < 0; R > 7; C < 0; C > 7 -> % Check if current position is out of board boundaries
            none;
        true ->
            case gb_sets:is_member({R, C}, QueenSet) of
                true -> 
                    {R, C}; % Found a queen at this position, it's the closest in this direction
                false -> 
                    find_closest_queen_in_direction(R + DR, C + DC, DR, DC, QueenSet) % No queen here, continue searching in the same direction
            end
    end.