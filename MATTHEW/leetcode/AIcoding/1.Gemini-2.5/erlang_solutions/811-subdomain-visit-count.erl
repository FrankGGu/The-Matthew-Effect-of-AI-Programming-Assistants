-module(solution).
-export([subdomainVisits/1]).

subdomainVisits(Cpdomains) ->
    InitialTree = gb_trees:empty(),

    FinalTree = lists:foldl(
        fun(CpdomainStr, AccTree) ->
            process_cpdomain(CpdomainStr, AccTree)
        end,
        InitialTree,
        Cpdomains
    ),

    lists:map(
        fun({Domain, Count}) ->
            io_lib:format("~p ~s", [Count, Domain])
        end,
        gb_trees:to_list(FinalTree)
    ).

process_cpdomain(CpdomainStr, AccTree) ->
    [CountStr, FullDomainStr] = string:tokens(CpdomainStr, " "),
    Count = list_to_integer(CountStr),

    Subdomains = get_subdomains(FullDomainStr),

    lists:foldl(
        fun(Subdomain, CurrentTree) ->
            gb_trees:update(Subdomain, fun(ExistingCount) -> ExistingCount + Count end, Count, CurrentTree)
        end,
        AccTree,
        Subdomains
    ).

get_subdomains(Domain) ->
    get_subdomains_recursive(Domain, []).

get_subdomains_recursive("", Acc) ->
    lists:reverse(Acc);
get_subdomains_recursive(Domain, Acc) ->
    case string:str(Domain, ".") of
        0 ->
            lists:reverse([Domain | Acc]);
        Index ->
            TailDomain = string:substr(Domain, Index + 1),
            get_subdomains_recursive(TailDomain, [Domain | Acc])
    end.