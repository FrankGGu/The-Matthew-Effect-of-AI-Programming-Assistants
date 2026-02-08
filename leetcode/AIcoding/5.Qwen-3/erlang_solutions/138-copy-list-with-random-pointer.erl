-module(solve).
-export([copyRandomList/1]).

-record(Node, {val, next, random}).

copyRandomList(undefined) ->
    undefined;
copyRandomList(#Node{val=Val, next=Next, random=Random}) ->
    #Node{val=Val, next=copyRandomList(Next), random=copyRandomList(Random)}.

copyRandomList(Head) ->
    copyRandomList(Head, dict:new()).

copyRandomList(undefined, _) ->
    undefined;
copyRandomList(#Node{val=Val, next=Next, random=Random}, Dict) ->
    case dict:find(Head, Dict) of
        {ok, Copy} ->
            Copy;
        error ->
            Copy = #Node{val=Val, next=undefined, random=undefined},
            dict:store(Head, Copy, Dict),
            Copy#Node{next=copyRandomList(Next, Dict), random=copyRandomList(Random, Dict)}
    end.