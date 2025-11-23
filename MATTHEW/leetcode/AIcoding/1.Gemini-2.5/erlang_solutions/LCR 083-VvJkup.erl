-module(solution).
-export([permute/1]).

permute([]) ->
    [[]];
permute(List) ->
    lists:flatmap(
        fun(X) ->
            Remaining = lists:delete(X, List),
            SubPerms = permute(Remaining),
            [[X | P] || P <- SubPerms]
        end,
        List
    ).