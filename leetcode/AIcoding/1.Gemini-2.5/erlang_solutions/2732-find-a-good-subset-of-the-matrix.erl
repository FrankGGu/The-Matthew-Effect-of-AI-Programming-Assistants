-module(solution).
-export([find_good_subset_of_the_matrix/1]).

row_to_int(Row) ->
    lists:foldl(fun(Bit, Acc) -> (Acc bsl 1) bor Bit end, 0, Row).

find_good_subset_of_the_matrix(Grid) ->
    N = length(hd(Grid)),
    AllOnesPattern = (1 bsl N) - 1,

    SeenPatterns = lists:duplicate(1 bsl N, 0),

    find_good_subset_of_the_matrix_loop(1, Grid, SeenPatterns, AllOnesPattern).

find_good_subset_of_the_matrix_loop(RowIndex, [CurrentRow | RestOfGrid], SeenPatterns, AllOnesPattern) ->
    CurrentPattern = row_to_int(CurrentRow),

    if CurrentPattern == 0 ->
        [RowIndex];
    true ->
        FoundPair = check_pairs(0, CurrentPattern, SeenPatterns, AllOnesPattern, RowIndex),
        case FoundPair of
            [] ->
                PrevSeenIndex = lists:nth(CurrentPattern + 1, SeenPatterns),
                NewSeenPatterns = 
                    if PrevSeenIndex == 0 ->
                        lists:replace_nth(CurrentPattern + 1, RowIndex, SeenPatterns);
                    true ->
                        SeenPatterns
                    end,

                find_good_subset_of_the_matrix_loop(RowIndex + 1, RestOfGrid, NewSeenPatterns, AllOnesPattern);
            _ ->
                FoundPair
        end
    end;
find_good_subset_of_the_matrix_loop(_RowIndex, [], _SeenPatterns, _AllOnesPattern) ->
    [].

check_pairs(PrevPattern, CurrentPattern, SeenPatterns, AllOnesPattern, CurrentRowIndex) when PrevPattern =< AllOnesPattern ->
    PrevSeenIndex = lists:nth(PrevPattern + 1, SeenPatterns),
    if PrevSeenIndex /= 0 ->
        if (CurrentPattern bor PrevPattern) /= AllOnesPattern ->
            [PrevSeenIndex, CurrentRowIndex];
        true ->
            check_pairs(PrevPattern + 1, CurrentPattern, SeenPatterns, AllOnesPattern, CurrentRowIndex)
        end;
    true ->
        check_pairs(PrevPattern + 1, CurrentPattern, SeenPatterns, AllOnesPattern, CurrentRowIndex)
    end;
check_pairs(_PrevPattern, _CurrentPattern, _SeenPatterns, _AllOnesPattern, _CurrentRowIndex) ->
    [].