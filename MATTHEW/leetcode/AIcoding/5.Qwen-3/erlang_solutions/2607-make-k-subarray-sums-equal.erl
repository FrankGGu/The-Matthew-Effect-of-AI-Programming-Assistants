-module(solution).
-export([main/0]).

main() ->
    Input = io:get_line(""),
    [K] = string:tokens(Input, " "),
    KInt = list_to_integer(K),
    S = io:get_line(""),
    SList = string:tokens(S, " "),
    List = lists:map(fun erlang:list_to_integer/1, SList),
    Result = solve(List, KInt),
    io:format("~p~n", [Result]).

solve(List, K) ->
    N = length(List),
    if
        N < 2*K -> 0;
        true ->
            Max = lists:max(List),
            Min = lists:min(List),
            Count = count_occurrences(List, Max) + count_occurrences(List, Min),
            if
                Count >= K -> 0;
                true -> K - Count
            end
    end.

count_occurrences([], _) -> 0;
count_occurrences([H | T], Target) ->
    if
        H == Target -> 1 + count_occurrences(T, Target);
        true -> count_occurrences(T, Target)
    end.