-spec arrange_coins(integer()) -> integer().
arrange_coins(N) ->
    %% Use binary search to find the maximum k such that k*(k+1)/2 <= N
    arrange_coins_bs(0, N, N).

arrange_coins_bs(Low, High, N) when Low =< High ->
    Mid = (Low + High) div 2,
    Sum = Mid * (Mid + 1) div 2,
    case Sum =< N of
        true ->
            case (Mid + 1) * (Mid + 2) div 2 =< N of
                true -> arrange_coins_bs(Mid + 1, High, N);
                false -> Mid
            end;
        false ->
            arrange_coins_bs(Low, Mid - 1, N)
    end;
arrange_coins_bs(_, _, _) -> 0.
