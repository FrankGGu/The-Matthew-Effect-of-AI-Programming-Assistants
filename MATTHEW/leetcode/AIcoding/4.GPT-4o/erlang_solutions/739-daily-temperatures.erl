-module(solution).
-export([dailyTemperatures/1]).

dailyTemperatures(T) ->
    N = length(T),
    Res = lists:duplicate(N, 0),
    dailyTemperatures(T, Res, N, 0).

dailyTemperatures(_, Res, 0, _) ->
    Res;
dailyTemperatures(T, Res, N, PrevIndex) ->
    CurrentTemp = lists:nth(N, T),
    NewRes = case lists:drop(PrevIndex, T) of
        [] -> Res;
        SubList when lists:all(fun(X) -> X <= CurrentTemp end, SubList) ->
            dailyTemperatures(T, Res, N - 1, PrevIndex + 1);
        SubList ->
            NewIndex = lists:find(fun(X) -> X > CurrentTemp end, SubList) + PrevIndex,
            NewRes1 = lists:replace(N, NewIndex - PrevIndex, Res),
            dailyTemperatures(T, NewRes1, N - 1, PrevIndex + 1)
    end,
    NewRes.