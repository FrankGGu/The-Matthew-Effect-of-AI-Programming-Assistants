-module(naming_a_company).
-export([numUniqueCompanies/1]).

numUniqueCompanies(Names) ->
    Count = maps:from_list([{Name, 1} || Name <- Names]),
    maps:size(Count).