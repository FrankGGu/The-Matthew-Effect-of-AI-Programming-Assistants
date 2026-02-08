-module(subdomain_visit_count).
-export([subdomain_visits/1]).

subdomain_visits(Counts) ->
    CountsList = lists:map(fun(Count) ->
        {N, Domain} = string:split(Count, " ", all),
        {list_to_integer(N), Domain}
    end, Counts),
    Visited = lists:foldl(fun({N, Domain}, Acc) ->
        Domains = subdomains(Domain),
        lists:foldl(fun(D, A) -> 
            case lists:keyfind(D, 1, A) of
                false -> [{D, N} | A];
                {D, C} -> [{D, C + N} | lists:keydelete(D, 1, A)]
            end
        end, Acc, Domains)
    end, [], CountsList),
    lists:map(fun({D, N}) -> integer_to_list(N) ++ " " ++ D end, lists:sort(fun({D1, _}, {D2, _}) -> D1 < D2 end, Visited)).

subdomains(Domain) ->
    Parts = string:split(Domain, "."),
    lists:map(fun(X) -> lists:foldl(fun(Y, Acc) -> Y ++ "." ++ Acc end, X, lists:reverse(tl(Parts))) end, Parts).