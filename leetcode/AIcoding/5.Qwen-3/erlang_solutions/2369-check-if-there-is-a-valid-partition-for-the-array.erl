-module(solution).
-export([valid_partition/1]).

valid_partition(Nums) ->
    valid_partition(Nums, 0, dict:new()).

valid_partition([], _, _) ->
    true;
valid_partition([N], _, _) ->
    false;
valid_partition([N1, N2], _, _) ->
    N1 == N2;
valid_partition([N1, N2, N3], _, _) ->
    (N1 == N2 andalso N2 == N3) orelse (N2 - N1 == 1 andalso N3 - N2 == 1);
valid_partition(Nums, Index, Memo) ->
    case dict:is_key(Index, Memo) of
        true ->
            dict:fetch(Index, Memo);
        false ->
            Result = case length(Nums) of
                Len when Len >= 2 ->
                    case valid_partition(Nums, Index + 2, Memo) of
                        true ->
                            true;
                        _ ->
                            case length(Nums) >= 3 of
                                true ->
                                    case (lists:nth(Index + 1, Nums) == lists:nth(Index + 2, Nums) andalso lists:nth(Index + 2, Nums) == lists:nth(Index + 3, Nums)) orelse
                                         (lists:nth(Index + 1, Nums) + 1 == lists:nth(Index + 2, Nums) andalso lists:nth(Index + 2, Nums) + 1 == lists:nth(Index + 3, Nums)) of
                                        true ->
                                            valid_partition(Nums, Index + 3, Memo);
                                        _ ->
                                            false
                                    end;
                                false ->
                                    false
                            end;
                        _ ->
                            false
                    end;
                _ ->
                    false
            end,
            dict:store(Index, Result, Memo),
            Result.