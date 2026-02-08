-spec xor_queries(Arr :: [integer()], Queries :: [[integer()]]) -> [integer()].
xor_queries(Arr, Queries) ->
    N = length(Arr),
    Prefix = lists:foldl(fun(X, Acc) -> 
                             case Acc of
                                 [] -> [X];
                                 _ -> [X bxor hd(Acc) | Acc]
                             end
                         end, [], Arr),
    PrefixXor = lists:reverse(Prefix),
    lists:map(fun([L, R]) ->
                  if
                      L == 0 -> lists:nth(R + 1, PrefixXor);
                      true -> lists:nth(R + 1, PrefixXor) bxor lists:nth(L, PrefixXor)
                  end
              end, Queries).