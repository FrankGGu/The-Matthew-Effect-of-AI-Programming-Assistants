-module(solution).
-export([min_swaps/1]).

min_swaps(Grid) ->
    N = length(Grid),
    TrailingZerosList = [count_trailing_zeros(Row) || Row <- Grid],
    solve(TrailingZerosList, N, 0, 0).

solve(Rows, N, CurrentRowIndex, TotalSwaps) when CurrentRowIndex == N ->
    TotalSwaps;
solve(Rows, N, CurrentRowIndex, TotalSwaps) ->
    RequiredTrailingZeros = N - 1 - CurrentRowIndex,
    {FoundRowIndex, _FoundValue} = find_suitable_row(Rows, CurrentRowIndex, RequiredTrailingZeros),
    if FoundRowIndex == -1 ->
        -1;
    true ->
        NewTotalSwaps = TotalSwaps + (FoundRowIndex - CurrentRowIndex),
        NewRows = move_element(Rows, FoundRowIndex, CurrentRowIndex),
        solve(NewRows, N, CurrentRowIndex + 1, NewTotalSwaps)
    end.

find_suitable_row(Rows, SearchStartIndex, Required) ->
    find_suitable_row_loop(Rows, SearchStartIndex, Required).

find_suitable_row_loop(Rows, CurrentCheckIndex, Required) ->
    if CurrentCheckIndex >= length(Rows) ->
        {-1, -1};
    true ->
        Value = lists:nth(CurrentCheckIndex + 1, Rows),
        if Value >= Required ->
            {CurrentCheckIndex, Value};
        true ->
            find_suitable_row_loop(Rows, CurrentCheckIndex + 1, Required)
        end
    end.

move_element(Rows, FromIndex, ToIndex) ->
    {BeforeFrom, FromAndAfter} = lists:split(FromIndex, Rows),
    ElementToMove = hd(FromAndAfter),
    AfterFrom = tl(FromAndAfter),
    ListWithoutElement = BeforeFrom ++ AfterFrom,
    {BeforeTo, AfterTo} = lists:split(ToIndex, ListWithoutElement),
    BeforeTo ++ [ElementToMove] ++ AfterTo.

count_trailing_zeros(Row) ->
    count_trailing_zeros_loop(lists:reverse(Row), 0).

count_trailing_zeros_loop([], Count) ->
    Count;
count_trailing_zeros_loop([0 | T], Count) ->
    count_trailing_zeros_loop(T, Count + 1);
count_trailing_zeros_loop([1 | _], Count) ->
    Count.