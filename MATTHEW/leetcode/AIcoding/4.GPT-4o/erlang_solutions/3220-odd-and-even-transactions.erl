-module(solution).
-export([odd_even_transactions/1]).

odd_even_transactions(Transactions) ->
    lists:foldl(fun({Amount, Id}, Acc) ->
        case lists:keyfind(Id, 1, Acc) of
            false -> [{Id, Amount} | Acc];
            {Id, PrevAmount} -> [{Id, PrevAmount + Amount} | lists:keydelete(Id, 1, Acc)]
        end
    end, [], Transactions) 
    |> lists:filter(fun({_, Amount}) -> Amount rem 2 =:= 1 end)
    |> lists:map(fun({Id, _}) -> Id end).