-module(solution).
-export([minMaxGame/1]).

minMaxGame(Nums) ->
    case length(Nums) of
        1 ->
            hd(Nums);
        _ ->
            NewList = generate_next_level(Nums, 0, []),
            minMaxGame(NewList)
    end.

generate_next_level([A, B | Rest], Index, Acc) ->
    NewElement = case Index rem 2 of
                     0 -> min(A, B);
                     1 -> max(A, B)
                 end,
    generate_next_level(Rest, Index + 1, [NewElement | Acc]).
generate_next_level([], _, Acc) ->
    lists:reverse(Acc).