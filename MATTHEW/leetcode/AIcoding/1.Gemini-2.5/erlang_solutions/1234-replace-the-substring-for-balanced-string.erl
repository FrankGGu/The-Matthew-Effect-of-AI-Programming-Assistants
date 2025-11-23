-module(solution).
-export([balanced_string_replace/1]).

-spec balanced_string_replace(S :: unicode:unicode_binary()) -> integer().
balanced_string_replace(S_bin) ->
    N = binary:len(S_bin),
    K = N div 4,

    InitialCounts = #{'Q' => 0, 'W' => 0, 'E' => 0, 'R' => 0},
    TotalCounts = calculate_total_counts(S_bin, N, InitialCounts),

    IsBalanced = lists:all(fun(Char) -> maps:get(Char, TotalCounts) == K end, ['Q', 'W', 'E', 'R']),
    if IsBalanced ->
        0;
    true ->
        IsConditionMet = fun(WC) ->
            lists:all(fun(Char) ->
                maps:get(Char, TotalCounts) - maps:get(Char, WC) =< K
            end, ['Q', 'W', 'E', 'R'])
        end,

        solve(S_bin, N, K, TotalCounts, 0, 0, InitialCounts, N, IsConditionMet)
    end.

calculate_total_counts(_S_bin, Index, Acc) when Index == 0 ->
    Acc;
calculate_total_counts(S_bin, Index, Acc) ->
    Char = binary:at(S_bin, Index - 1),
    NewAcc = maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc),
    calculate_total_counts(S_bin, Index - 1, NewAcc).

solve(_S_bin, _N, _K, _TotalCounts, _Left, Right, _WindowCounts, MinLen, _IsConditionMet) when Right == _N ->
    MinLen;
solve(S_bin, N, K, TotalCounts, Left, Right, WindowCounts, MinLen, IsConditionMet) ->
    CharRight = binary:at(S_bin, Right),
    NewWindowCounts = maps:update_with(CharRight, fun(V) -> V + 1 end, 1, WindowCounts),

    {UpdatedLeft, UpdatedWindowCounts, CurrentMinLen} = 
        shrink_loop(S_bin, N, K, TotalCounts, Left, Right, NewWindowCounts, MinLen, IsConditionMet),

    solve(S_bin, N, K, TotalCounts, UpdatedLeft, Right + 1, UpdatedWindowCounts, CurrentMinLen, IsConditionMet).

shrink_loop(S_bin, _N, _K, _TotalCounts, Left, Right, WindowCounts, MinLen, IsConditionMet) ->
    if IsConditionMet(WindowCounts) ->
        NewMinLen = min(MinLen, Right - Left + 1),

        CharLeft = binary:at(S_bin, Left),
        NewWindowCounts = maps:update_with(CharLeft, fun(V) -> V - 1 end, 0, WindowCounts),

        shrink_loop(S_bin, _N, _K, _TotalCounts, Left + 1, Right, NewWindowCounts, NewMinLen, IsConditionMet);
    true ->
        {Left, WindowCounts, MinLen}
    end.