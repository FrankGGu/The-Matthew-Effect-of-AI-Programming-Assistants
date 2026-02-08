-module(number_container_system).
-export([new/0, change/3, find/1, get_last_page/0]).

new() ->
    #{containers => #{}, last_page => 0}.

change(ContainerId, Index, Number) ->
    Containers = maps:get(containers, state()),
    NewContainers = maps:update(ContainerId, {Index, Number}, Containers),
    put(state, #{containers => NewContainers, last_page => maps:get(last_page, state())}).

find(Index) ->
    Containers = maps:get(containers, state()),
    lists:foldl(fun({_ContainerId, {I, N}}, Acc) ->
        if I == Index -> [N | Acc];
           true -> Acc
        end
    end, [], maps:to_list(Containers)).

get_last_page() ->
    maps:get(last_page, state()).