-module(browser_history).
-export([init/1, visit/2, back/1, forward/1]).

-record(history, {current, back_stack = [], forward_stack = []}).

init(StartUrl) ->
    #history{current = StartUrl}.

visit(History, Url) ->
    BackStack = [History#history.current | History#history.back_stack],
    #history{current = Url, back_stack = BackStack, forward_stack = []}.

back(History) ->
    case History#history.back_stack of
        [] ->
            History;
        [Prev | Rest] ->
            ForwardStack = [History#history.current | History#history.forward_stack],
            #history{current = Prev, back_stack = Rest, forward_stack = ForwardStack}
    end.

forward(History) ->
    case History#history.forward_stack of
        [] ->
            History;
        [Next | Rest] ->
            BackStack = [History#history.current | History#history.back_stack],
            #history{current = Next, back_stack = BackStack, forward_stack = Rest}
    end.