-module(solution).
-export([findLongestChain/1]).

findLongestChain(Pairs) ->
    PairsSorted = lists:sort(fun({A1, B1}, {A2, B2}) -> 
        case B1 < B2 of 
            true -> true; 
            false -> A1 < A2 
        end 
    end, Pairs),
    find_chain(PairsSorted, -1, 0).

find_chain([], _, Count) -> Count;
find_chain([{A, B} | Rest], LastEnd, Count) ->
    case A > LastEnd of
        true -> find_chain(Rest, B, Count + 1);
        false -> find_chain(Rest, LastEnd, Count)
    end.