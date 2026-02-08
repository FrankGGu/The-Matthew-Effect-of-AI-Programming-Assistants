-spec subdomain_visits(Cpdomains :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
subdomain_visits(Cpdomains) ->
    Counts = lists:foldl(
        fun(Domain, Acc) ->
            [CountStr, FullDomain] = binary:split(Domain, <<" ">>),
            Count = binary_to_integer(CountStr),
            Domains = get_subdomains(FullDomain),
            lists:foldl(
                fun(D, Map) ->
                    maps:update_with(D, fun(V) -> V + Count end, Count, Map)
                end,
                Acc,
                Domains
            )
        end,
        maps:new(),
        Cpdomains
    ),
    maps:fold(
        fun(Domain, Count, Acc) ->
            [<<(integer_to_binary(Count))/binary, " ", Domain/binary>> | Acc]
        end,
        [],
        Counts
    ).

get_subdomains(FullDomain) ->
    Parts = binary:split(FullDomain, <<".">>, [global]),
    lists:foldl(
        fun(_, []) -> [];
           (_, Acc) ->
            Domain = binary:join(lists:reverse(Acc), <<".">>),
            [Domain | tl(Acc)]
        end,
        [],
        lists:reverse(Parts)
    ).