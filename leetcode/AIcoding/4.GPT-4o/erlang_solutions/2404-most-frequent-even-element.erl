-module(solution).
-export([most_frequent_even_element/1]).

most_frequent_even_element(List) ->
    lists:foldl(fun(X, Acc) ->
        case X rem 2 of
            0 -> 
                case lists:keyfind(X, 1, Acc) of
                    {X, Count} -> [{X, Count + 1} | lists:keydelete(X, 1, Acc)];
                    false -> [{X, 1} | Acc]
                end;
            _ -> Acc
        end
    end, [], List)
    |> lists:sort(fun({_, Count1}, {_, Count2}) -> Count1 > Count2 end)
    |> case lists:foldl(fun({Val, _}, Acc) -> case Acc of 
                                                   [] -> [Val]; 
                                                   _ -> Acc 
                                               end 
                       end, [], lists:sublist(1)) of
        [] -> -1;
        [MostFrequent] -> MostFrequent
    end.