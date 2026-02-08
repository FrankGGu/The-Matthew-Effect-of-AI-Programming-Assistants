-module(solution).
-export([best_shop/1]).

best_shop(S) ->
    {MinPenalty, MinIndex} = lists:foldl(fun (C, {Min, Index}) ->
        case C of
            'Y' -> {Min, Index + 1};
            'N' -> {Min + 1, Index + 1}
        end
    end, {0, 0}, string:to_list(S)),
    case MinPenalty of
        0 -> MinIndex;
        _ -> MinIndex + 1
    end.