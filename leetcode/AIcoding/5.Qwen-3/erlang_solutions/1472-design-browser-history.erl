-module(browser_history).
-export([new/1, visit/2, back/2, forward/2]).

new(Url) ->
    {history, [Url], [], []}.

visit({history, Current, BackStack, _}, Url) ->
    {history, [Url | BackStack], [], []}.

back({history, [Current | _] = History, BackStack, ForwardStack}, Steps) ->
    if
        Steps == 0 -> {history, History, BackStack, ForwardStack};
        true ->
            case lists:split(Steps, History) of
                {[], _} -> {history, History, BackStack, ForwardStack};
                {Back, [Current | Rest]} ->
                    NewBackStack = Back ++ BackStack,
                    NewHistory = [Current | Rest],
                    {history, NewHistory, NewBackStack, ForwardStack}
            end
    end.

forward({history, History, BackStack, ForwardStack}, Steps) ->
    if
        Steps == 0 -> {history, History, BackStack, ForwardStack};
        true ->
            case lists:split(Steps, ForwardStack) of
                {[], _} -> {history, History, BackStack, ForwardStack};
                {Forward, [Next | Rest]} ->
                    NewForwardStack = Rest,
                    NewHistory = [Next | History],
                    NewBackStack = BackStack ++ [Current || [Current | _] <- [History]],
                    {history, NewHistory, NewBackStack, NewForwardStack}
            end
    end.