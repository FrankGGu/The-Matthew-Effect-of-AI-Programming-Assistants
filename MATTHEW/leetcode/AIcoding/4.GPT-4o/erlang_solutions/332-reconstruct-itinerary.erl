%% -spec find_itinerary(Tickets :: [[unicode:unicode_binary()]]) -> [unicode:unicode_binary()].
find_itinerary(Tickets) ->
    Tickets1 = lists:sort(fun({From1, _}, {From2, _}) -> From1 < From2 end, Tickets),
    lists:append([["JFK"]], dfs("JFK", Tickets1, [])).

dfs(_, [], Acc) -> lists:reverse(Acc);
dfs(From, Tickets, Acc) ->
    case lists:prefix({From, _}, Tickets) of
        true -> 
            {From, To} = hd(Tickets),
            dfs(To, tl(Tickets), [From | Acc]);
        false -> dfs(From, tl(Tickets), Acc)
    end.
