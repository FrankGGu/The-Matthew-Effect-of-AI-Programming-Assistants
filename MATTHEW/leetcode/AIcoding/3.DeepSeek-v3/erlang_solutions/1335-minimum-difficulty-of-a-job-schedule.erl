-module(solution).
-export([min_difficulty/2]).

min_difficulty(JobDifficulty, D) ->
    Jobs = JobDifficulty,
    N = length(Jobs),
    if
        N < D -> -1;
        true ->
            DP = lists:duplicate(N, lists:duplicate(D, 1000000)),
            DP1 = update_dp(1, 1, Jobs, DP),
            DP2 = lists:foldl(fun(Day, Acc) ->
                update_dp_for_day(Day, Jobs, Acc)
            end, DP1, lists:seq(2, D)),
            lists:nth(D, lists:nth(N, DP2))
    end.

update_dp_for_day(Day, Jobs, DP) ->
    lists:foldl(fun(I, Acc) ->
        Max = get_max(Jobs, I, Day),
        lists:foldl(fun(J, Acc1) ->
            case J >= Day andalso J =< I of
                true ->
                    Prev = case J - 1 < Day - 1 of
                        true -> 1000000;
                        false -> lists:nth(Day - 1, lists:nth(J - 1, Acc1))
                    end,
                    Current = lists:nth(Day, lists:nth(I, Acc1)),
                    NewVal = min(Current, Prev + Max),
                    set_dp(I, Day, NewVal, Acc1);
                false ->
                    Acc1
            end
        end, Acc, lists:seq(1, I))
    end, DP, lists:seq(Day, length(Jobs))).

get_max(Jobs, I, Day) ->
    lists:max(lists:sublist(Jobs, Day, I - Day + 1)).

update_dp(I, Day, Jobs, DP) ->
    Max = lists:nth(I, Jobs),
    if
        Day == 1 ->
            Prev = if I == 1 -> 0; true -> lists:nth(Day, lists:nth(I - 1, DP)) end,
            NewVal = Prev + Max,
            set_dp(I, Day, NewVal, DP);
        true ->
            DP
    end.

set_dp(I, Day, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setnth(Day, Val, Row),
    setnth(I, NewRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N-1, Val, T)].