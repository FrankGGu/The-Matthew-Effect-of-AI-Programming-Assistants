-module(init).
-export([init/1, insert/2, get_root/1]).

-record(node, {val, left, right}).

-spec init_(Root :: #node{}) -> any().
init(Root) ->
    {ok, spawn(fun() -> loop([Root], []) end)}.

loop([], []) ->
    ok;
loop([], NextLevel) ->
    loop(lists:reverse(NextLevel), []);
loop([#node{left = null, right = null} = Node | Rest], NextLevel) ->
    receive
        {insert, Val, Pid} ->
            NewNode = #node{val = Val, left = null, right = null},
            Pid ! {ok, Node#node{left = NewNode}},
            loop(Rest, [NewNode | NextLevel]);
        {get_root, Pid} ->
            Pid ! {ok, Node},
            loop(Rest, NextLevel)
    end;
loop([#node{left = Left, right = null} = Node | Rest], NextLevel) when Left =/= null ->
    receive
        {insert, Val, Pid} ->
            NewNode = #node{val = Val, left = null, right = null},
            Pid ! {ok, Node#node{right = NewNode}},
            loop(Rest, [NewNode | NextLevel]);
        {get_root, Pid} ->
            Pid ! {ok, Node},
            loop(Rest, NextLevel)
    end;
loop([#node{left = Left, right = Right} = Node | Rest], NextLevel) when Left =/= null, Right =/= null ->
    receive
        {insert, Val, Pid} ->
            NewNode = #node{val = Val, left = null, right = null},
            Pid ! {ok, Node},
            loop(Rest, [Left, Right | NextLevel]);
        {get_root, Pid} ->
            Pid ! {ok, Node},
            loop(Rest, NextLevel)
    end.

-spec insert(pid(), integer()) -> #node{}.
insert(Pid, Val) ->
    Pid ! {insert, Val, self()},
    receive
        {ok, Node} -> Node
    end.

-spec get_root(pid()) -> #node{}.
get_root(Pid) ->
    Pid ! {get_root, self()},
    receive
        {ok, Root} -> Root
    end.