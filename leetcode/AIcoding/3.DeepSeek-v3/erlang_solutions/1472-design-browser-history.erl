-module(browser_history).
-export([init/1, visit/2, back/2, forward/2]).

-record(browser, {history = [], forward_stack = []}).

init(Homepage) ->
    #browser{history = [Homepage]}.

visit(Url, Browser) ->
    #browser{history = History} = Browser,
    NewHistory = [Url | History],
    Browser#browser{history = NewHistory, forward_stack = []}.

back(Steps, Browser) ->
    #browser{history = History, forward_stack = ForwardStack} = Browser,
    case length(History) - 1 of
        AvailableSteps when AvailableSteps =< Steps ->
            {NewHistory, NewForwardStack} = lists:split(1, History),
            Browser#browser{history = NewHistory, forward_stack = lists:reverse(lists:nthtail(1, History)) ++ ForwardStack};
        _ ->
            {NewHistory, Moved} = lists:split(Steps + 1, History),
            Browser#browser{history = NewHistory, forward_stack = lists:reverse(Moved) ++ ForwardStack}
    end.

forward(Steps, Browser) ->
    #browser{history = History, forward_stack = ForwardStack} = Browser,
    case length(ForwardStack) of
        AvailableSteps when AvailableSteps =< Steps ->
            NewHistory = lists:reverse(ForwardStack) ++ History,
            Browser#browser{history = NewHistory, forward_stack = []};
        _ ->
            {Moved, NewForwardStack} = lists:split(Steps, ForwardStack),
            NewHistory = lists:reverse(Moved) ++ History,
            Browser#browser{history = NewHistory, forward_stack = NewForwardStack}
    end.