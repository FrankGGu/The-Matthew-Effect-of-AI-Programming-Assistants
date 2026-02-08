-module(solution).
-export([solution/1, getRandom/1]).

-record(state, {list, length}).

solution(Head) ->
    Len = list_length(Head),
    #state{list = Head, length = Len}.

getRandom(#state{list = List, length = Len}) ->
    N = rand:uniform(Len) - 1,
    nth(N, List).

list_length(List) ->
    list_length(List, 0).

list_length([], Acc) ->
    Acc;
list_length([_ | Rest], Acc) ->
    list_length(Rest, Acc + 1).

nth(0, [H | _]) ->
    H;
nth(N, [_ | T]) when N > 0 ->
    nth(N - 1, T).