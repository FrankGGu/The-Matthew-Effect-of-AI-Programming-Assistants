-module(subdomain_visit_count).
-export([main/0]).

main() ->
    Input = ["9001 discuss.leetcode.com", "500 google.com", "199 wikipedia.org", "100 en.wikipedia.org"],
    Result = subdomain_visit_count(Input),
    io:format("~p~n", [Result]).

subdomain_visit_count(Input) ->
    Counts = lists:foldl(fun(Entry, Acc) ->
        [NumStr | Domain] = string:split(Entry, " "),
        Num = list_to_integer(NumStr),
        Domains = get_subdomains(lists:flatten(Domain)),
        lists:foldl(fun(D, A) -> 
            Count = maps:get(D, A, 0),
            maps:put(D, Count + Num, A)
        end, Acc, Domains)
    end, #{}, Input),
    lists:sort([{K, V} || {K, V} <- maps:to_list(Counts)]).

get_subdomains(Domain) ->
    Parts = string:split(Domain, "."),
    lists:foldl(fun(Part, Acc) ->
        [Current | _] = lists:reverse(Acc),
        NewPart = string:join([Part, Current], "."),
        [NewPart | Acc]
    end, [lists:last(Parts)], lists:tl(Parts)).