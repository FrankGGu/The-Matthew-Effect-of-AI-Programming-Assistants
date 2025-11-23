-module(skiplist).
-export([new/0, search/2, add/2, erase/2]).

-define(MAX_LEVEL, 16).
-define(P, 0.5).

-record(node, {
    key :: integer(),
    forward = [] :: [#node{}]
}).

new() ->
    Head = #node{key = -1, forward = lists:duplicate(?MAX_LEVEL, undefined)},
    {Head, ?MAX_LEVEL}.

search({Head, _}, Target) ->
    search(Head, Target, ?MAX_LEVEL - 1).

search(Node, Target, Level) when Level >= 0 ->
    Next = element(Level + 1, Node#node.forward),
    if
        Next =/= undefined, Next#node.key < Target ->
            search(Next, Target, Level);
        true ->
            search(Node, Target, Level - 1)
    end;
search(Node, Target, _) ->
    Next = element(1, Node#node.forward),
    Next =/= undefined andalso Next#node.key =:= Target.

add({Head, MaxLevel}, Num) ->
    Update = lists:duplicate(MaxLevel, undefined),
    {NewHead, NewUpdate} = find(Head, Num, MaxLevel - 1, Update),
    Level = random_level(),
    NewNode = #node{key = Num, forward = lists:duplicate(Level, undefined)},
    add(NewHead, NewNode, NewUpdate, Level - 1),
    {NewHead, MaxLevel}.

find(Node, Target, Level, Update) when Level >= 0 ->
    Next = element(Level + 1, Node#node.forward),
    if
        Next =/= undefined, Next#node.key < Target ->
            find(Next, Target, Level, Update);
        true ->
            NewUpdate = setelement(Level + 1, Update, Node),
            find(Node, Target, Level - 1, NewUpdate)
    end;
find(Node, _, _, Update) ->
    {Node, Update}.

add(_, _, _, Level) when Level < 0 ->
    ok;
add(Head, Node, Update, Level) ->
    Next = element(Level + 1, element(Level + 1, Update)#node.forward),
    NewForward = setelement(Level + 1, Node#node.forward, Next),
    NewNode = Node#node{forward = NewForward},
    NewUpdate = setelement(Level + 1, element(Level + 1, Update)#node.forward, NewNode),
    add(Head, Node, Update, Level - 1).

erase({Head, MaxLevel}, Num) ->
    Update = lists:duplicate(MaxLevel, undefined),
    {FoundNode, NewUpdate} = find(Head, Num, MaxLevel - 1, Update),
    Next = element(1, FoundNode#node.forward),
    if
        Next =/= undefined, Next#node.key =:= Num ->
            erase(FoundNode, Next, NewUpdate, MaxLevel - 1),
            true;
        true ->
            false
    end.

erase(_, Node, Update, Level) when Level >= 0 ->
    Pred = element(Level + 1, Update),
    Next = element(Level + 1, Node#node.forward),
    if
        Pred =/= undefined, element(Level + 1, Pred#node.forward) =:= Node ->
            NewPredForward = setelement(Level + 1, Pred#node.forward, Next),
            NewPred = Pred#node{forward = NewPredForward},
            NewUpdate = setelement(Level + 1, Update, NewPred),
            erase(undefined, Node, NewUpdate, Level - 1);
        true ->
            erase(undefined, Node, Update, Level - 1)
    end;
erase(_, _, _, _) ->
    ok.

random_level() ->
    random_level(1).

random_level(Level) ->
    case rand:uniform() < ?P andalso Level < ?MAX_LEVEL of
        true -> random_level(Level + 1);
        false -> Level
    end.