-module(solution).
-export([count_hills_valleys/1]).

count_hills_valleys(Nums) ->
    FilteredNums = filter_duplicates(Nums),
    case length(FilteredNums) of
        Len when Len < 3 -> 0;
        _ -> count_hv_recursive(tl(FilteredNums), hd(FilteredNums), 0)
    end.

filter_duplicates([]) ->
    [];
filter_duplicates([H|T]) ->
    filter_duplicates_impl(T, H, [H]).

filter_duplicates_impl([], _Prev, Acc) ->
    lists:reverse(Acc);
filter_duplicates_impl([H|T], Prev, Acc) when H == Prev ->
    filter_duplicates_impl(T, Prev, Acc);
filter_duplicates_impl([H|T], _Prev, Acc) ->
    filter_duplicates_impl(T, H, [H|Acc]).

count_hv_recursive([_], _Prev, Count) ->
    Count;
count_hv_recursive([Current, Next | Rest], Prev, Count) ->
    NewCount = case {Prev, Current, Next} of
        {P, C, N} when P < C andalso C > N -> Count + 1;
        {P, C, N} when P > C andalso C < N -> Count + 1;
        _ -> Count
    end,
    count_hv_recursive([Next | Rest], Current, NewCount).