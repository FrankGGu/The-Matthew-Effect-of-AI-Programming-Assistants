-module(minimum_moves).
-export([min_moves/3]).

min_moves(Target, MaxDoubles, Moves) ->
    min_moves_helper(Target, MaxDoubles, Moves).

min_moves_helper(Target, MaxDoubles, Moves) ->
    case Target of
        1 -> Moves;
        _ ->
            if MaxDoubles == 0 orelse Target rem 2 /= 0 then
                min_moves_helper(Target - 1, MaxDoubles, Moves + Target - 1)
            else
                if Target rem 2 == 0 andalso MaxDoubles > 0 then
                    min_moves_helper(Target div 2, MaxDoubles - 1, Moves + 1)
                else
                    min_moves_helper(Target - 1, MaxDoubles, Moves + 1)
                end
            end
    end.