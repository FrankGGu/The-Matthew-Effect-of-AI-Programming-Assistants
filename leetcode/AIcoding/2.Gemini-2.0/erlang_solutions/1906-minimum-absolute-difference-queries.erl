-module(minimum_absolute_difference_queries).
-export([min_difference/2]).

min_difference(Nums, Queries) ->
    Len = length(Nums),
    SortedNums = lists:sort(Nums),
    Diffs = calculate_diffs(SortedNums),
    [process_query(Query, SortedNums, Diffs, Len) || Query <- Queries].

calculate_diffs(SortedNums) ->
    calculate_diffs_helper(SortedNums, []).

calculate_diffs_helper([_], Acc) ->
    lists:reverse(Acc);
calculate_diffs_helper([H1, H2 | T], Acc) ->
    calculate_diffs_helper([H2 | T], [H2 - H1 | Acc]).

process_query([L, R], SortedNums, Diffs, Len) ->
    SubList = lists:sublist(SortedNums, L + 1, R - L + 1),
    case length(SubList) < 2 of
        true -> -1;
        false ->
            SortedSubList = lists:sort(SubList),
            SubDiffs = calculate_diffs(SortedSubList),
            case length(SubDiffs) > 0 of
                true ->
                    lists:min(SubDiffs);
                false ->
                    -1
            end
    end.