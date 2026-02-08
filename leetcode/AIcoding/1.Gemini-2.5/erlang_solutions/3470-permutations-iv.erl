-module(solution).
-export([permute/1]).

permute(Nums) ->
    permute_recursive(Nums).

permute_recursive([]) ->
    [[]];
permute_recursive(List) ->
    lists:flatmap(fun(X) ->
                      Remaining = lists:delete(X, List),
                      SubPermutations = permute_recursive(Remaining),
                      [ [X | SubPerm] || SubPerm <- SubPermutations ]
                  end, List).