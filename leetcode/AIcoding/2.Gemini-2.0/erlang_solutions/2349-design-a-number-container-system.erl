-module(number_container).
-export([start/0, new/0, put/2, get/1, change/2]).

start() ->
    spawn(fun() -> loop(dict:new()) end).

new() ->
    start().

put(Pid, Index, Number) ->
    Pid ! {put, Index, Number}.

get(Pid, Index) ->
    Pid ! {get, Index},
    receive
        {Pid, Result} ->
            Result
    end.

change(Pid, Index, Number) ->
    Pid ! {change, Index, Number}.

loop(Container) ->
    receive
        {put, Index, Number} ->
            NewContainer = dict:update(Number, fun(Indices) -> lists:sort(Indices ++ [Index]) end, [Index], Container),
            loop(NewContainer);
        {get, Index} ->
            Result = case dict:is_key(Index, Container) of
                         true ->
                             lists:foldl(fun(Number, Acc) ->
                                             case lists:member(Index, dict:fetch(Number, Container)) of
                                                 true -> Number;
                                                 false -> Acc
                                             end
                                         end, -1, dict:fetch_keys(Container));
                         false ->
                             -1
                     end,
            Sender = self(),
            Sender ! {self(), Result},
            loop(Container);
        {change, Index, Number} ->
            NewContainer = change_helper(Container, Index, Number),
            loop(NewContainer)
    end.

change_helper(Container, Index, Number) ->
    Container1 = lists:foldl(fun(K, Acc) ->
                                   case lists:member(Index, dict:fetch(K, Acc)) of
                                       true ->
                                           case dict:fetch(K, Acc) of
                                               [Index] ->
                                                   dict:erase(K, Acc);
                                               List ->
                                                   dict:store(K, lists:delete(Index, List), Acc)
                                           end;
                                       false ->
                                           Acc
                                   end
                               end, Container, dict:fetch_keys(Container)),
    dict:update(Number, fun(Indices) -> lists:sort(Indices ++ [Index]) end, [Index], Container1).