-module(minimum_white_tiles).
-export([minimum_white_tiles/3]).

minimum_white_tiles(floor, carpet_len, num_carpets) ->
    FloorList = string:to_list(floor),
    N = length(FloorList),
    memo(FloorList, N, carpet_len, num_carpets).

memo(FloorList, N, CarpetLen, NumCarpets) ->
    memo(FloorList, N, CarpetLen, NumCarpets, dict:new()).

memo(FloorList, N, CarpetLen, NumCarpets, Memo) ->
    case dict:is_key({N, NumCarpets}, Memo) of
        true ->
            dict:fetch({N, NumCarpets}, Memo);
        false ->
            Result = calculate(FloorList, N, CarpetLen, NumCarpets, Memo),
            dict:store({N, NumCarpets}, Result, Memo),
            Result
    end.

calculate(_, 0, _, _, _) ->
    0;
calculate(_, _, _, NumCarpets, _) when NumCarpets < 0 ->
    infinity;
calculate(FloorList, N, CarpetLen, NumCarpets, Memo) ->
    NoCover = (list_to_integer(string:substr(lists:nth(N, FloorList),1,1)) - 48) + memo(FloorList, N - 1, CarpetLen, NumCarpets, Memo),
    Cover = memo(FloorList, N - CarpetLen, CarpetLen, NumCarpets - 1, Memo),
    min(NoCover, Cover).

min(A, B) ->
    if A < B ->
        A;
    true ->
        B
    end.

infinity() ->
    1000000000.