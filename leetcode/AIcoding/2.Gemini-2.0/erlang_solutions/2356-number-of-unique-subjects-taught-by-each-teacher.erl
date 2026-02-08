-module(solution).
-export([solve/0]).

solve() ->
    io:format("~s~n", [solution()]).

solution() ->
    Q = "SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher GROUP BY teacher_id;",
    Result = ets:new(result, [set, protected]),
    try
        Data = qlc:q(Q, [{bindings, []}]),
        lists:foreach(fun({TeacherId, Count}) ->
                          ets:insert(Result, {TeacherId, Count})
                      end, Data),
        Records = ets:tab2list(Result),
        lists:sort(fun({T1, _}, {T2, _}) -> T1 < T2 end, Records)
    after
        ets:delete(Result)
    end.