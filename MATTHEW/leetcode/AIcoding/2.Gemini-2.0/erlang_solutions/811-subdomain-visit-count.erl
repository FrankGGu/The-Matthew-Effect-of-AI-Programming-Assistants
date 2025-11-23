-module(subdomain_visits).
-export([subdomain_visits/1]).

subdomain_visits(CPDomains) ->
  Counts = lists:foldl(
    fun(CPDomain, Acc) ->
      [CountStr, Domain] = string:split(CPDomain, " ", all),
      Count = list_to_integer(CountStr),
      Subdomains = string:split(Domain, ".", all),
      update_counts(Subdomains, Count, Acc)
    end,
    dict:new(),
    CPDomains
  ),
  lists:map(
    fun({Subdomain, Count}) ->
      integer_to_list(Count) ++ " " ++ Subdomain
    end,
    dict:to_list(Counts)
  ).

update_counts([], _Count, Acc) ->
  Acc;
update_counts(Subdomains, Count, Acc) ->
  Domain = string:join(Subdomains, "."),
  UpdatedAcc = dict:update_counter(Domain, Count, Acc),
  update_counts(tl(Subdomains), Count, UpdatedAcc).