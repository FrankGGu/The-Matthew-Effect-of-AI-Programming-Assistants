-module(solution).
-export([longest_palindrome/1]).

longest_palindrome(Words) ->
    Groups = lists:foldl(fun(W, Acc) -> 
        case lists:keyfind(W, 1, Acc) of
            false -> [{W, 1} | Acc];
            {W, Count} -> [{W, Count + 1} | lists:keydelete(W, 1, Acc)]
        end
    end, [], Words),
    Pairs = lists:filter(fun({W, Count}) -> Count > 1 end, Groups),
    SingleMiddle = lists:foldl(fun({W, _}, Acc) -> 
        case Acc of
            false -> W;
            _ -> Acc
        end
    end, false, lists:filter(fun({W, Count}) -> Count rem 2 =:= 1 end, Groups)),
    LengthPairs = lists:foldl(fun({W, Count}, Acc) -> Acc + Count * 2 end, 0, Pairs),
    case SingleMiddle of
        false -> LengthPairs;
        _ -> LengthPairs + 1
    end.