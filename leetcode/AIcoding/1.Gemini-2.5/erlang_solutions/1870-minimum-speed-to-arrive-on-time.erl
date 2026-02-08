-module(solution).
-export([minSpeedOnTime/2]).

minSpeedOnTime(Dist, Hour) ->
    N = length(Dist),

    %% If the minimum possible time (N-1 for the first N-1 trains, plus a tiny bit for the last)
    %% is greater than Hour, it's impossible.
    %% The minimum time for N-1 trains, even with infinite speed, is N-1 (each takes ceil(dist/inf) = 1).
    %% The last train always takes some positive time. So, minimum total time is > N-1.
    %% If Hour <= N-1, it's impossible.
    case Hour =< N - 1 of
        true ->
            -1;
        false ->
            Low = 1,
            High = 10000000, %% A sufficiently large upper bound for speed.
                            %% Max dist is 10^5. If speed is 10^7, dist/speed is 0.01.
                            %% ceil(dist/speed) becomes 1.
                            %% Total time becomes (N-1)*1 + dist[N-1]/10^7.
                            %% Since Hour > N-1, this will always be <= Hour.
                            %% So 10^7 is a safe upper bound for the answer.
            binary_search(Low, High, Dist, Hour, -1)
    end.

binary_search(Low, High, Dist, Hour, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, Dist, Hour) of
        true ->
            %% Mid is a possible speed, try for a lower speed
            binary_search(Low, Mid - 1, Dist, Hour, Mid);
        false ->
            %% Mid is too slow, need higher speed
            binary_search(Mid + 1, High, Dist, Hour, Ans)
    end;
binary_search(_Low, _High, _Dist, _Hour, Ans) ->
    Ans.

check(Speed, Dist, Hour) ->
    N = length(Dist),
    TotalTime = calculate_time(Dist, Speed, N, 0, 0.0),
    TotalTime =< Hour.

calculate_time([], _Speed, _N, _Index, Acc) ->
    Acc;
calculate_time([D | Rest], Speed, N, Index, Acc) ->
    Time = D / Speed,
    CurrentTime =
        case Index < N - 1 of
            true -> math:ceil(Time);
            false -> Time
        end,
    calculate_time(Rest, Speed, N, Index + 1, Acc + CurrentTime).