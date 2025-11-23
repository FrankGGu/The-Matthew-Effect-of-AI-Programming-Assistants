-module(solution).
-export([string_matching/1]).

string_matching(List) ->
    Matches = [X || X <- List, Y <- List, X /= Y, string:substring(Y, X)],
    lists:usort(Matches).