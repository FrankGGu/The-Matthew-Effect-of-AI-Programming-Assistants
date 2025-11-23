-module(time_needed_to_inform_all_employees).
-export([num_minutes, solve/3]).

num_minutes(N, HeadID, Managers, InformTime) ->
    solve(N, HeadID, Managers, InformTime).

solve(N, HeadID, Managers, InformTime) ->
    Graph = build_graph(N, Managers),
    max_time(HeadID, Graph, InformTime).

build_graph(N, Managers) ->
    build_graph(Managers, lists:seq(0, N - 1), []).

build_graph([], _, Acc) ->
    Acc;
build_graph([Manager | Rest], [Id | Ids], Acc) ->
    case Manager of
        -1 ->
            build_graph(Rest, Ids, Acc);
        _ ->
            NewAcc = case lists:keyfind(Manager, 1, Acc) of
                false ->
                    [{Manager, [Id]} | Acc];
                {Manager, Children} ->
                    lists:keyreplace(Manager, 1, Acc, {Manager, [Id | Children]})
            end,
            build_graph(Rest, Ids, NewAcc)
    end.

max_time(Employee, Graph, InformTime) ->
    case lists:keyfind(Employee, 1, Graph) of
        false ->
            InformTime[Employee + 1];
        {_, Children} ->
            Times = [max_time(Child, Graph, InformTime) + InformTime[Employee + 1] || Child <- Children],
            case Times of
                [] ->
                    InformTime[Employee + 1];
                _ ->
                    lists:max(Times)
            end
    end.