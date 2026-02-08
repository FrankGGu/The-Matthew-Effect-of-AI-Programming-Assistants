-module(solution).
-export([maximum_length/1]).

maximum_length(Nums) ->
    Counts = lists:foldl(
        fun(N, Acc) ->
            SFP = get_square_free_part(N),
            maps:update_with(SFP, fun(C) -> C + 1 end, 1, Acc)
        end,
        maps:new(),
        Nums
    ),
    case maps:is_empty(Counts) of
        true -> 0;
        false ->
            maps:fold(
                fun(_SFP, Count, CurrentMax) ->
                    max(Count, CurrentMax)
                end,
                0,
                Counts
            )
    end.

get_square_free_part(N) when N < 1 -> error(badarg);
get_square_free_part(1) -> 1;
get_square_free_part(N) ->
    get_square_free_part_recursive(N, 2).

get_square_free_part_recursive(N, I) when I * I =< N ->
    Square = I * I,
    case N rem Square of
        0 ->
            NewN = divide_by_square(N, Square),
            get_square_free_part_recursive(NewN, I + 1);
        _ ->
            get_square_free_part_recursive(N, I + 1)
    end;
get_square_free_part_recursive(N, _I) ->
    N.

divide_by_square(N, Square) ->
    case N rem Square of
        0 -> divide_by_square(N div Square, Square);
        _ -> N
    end.