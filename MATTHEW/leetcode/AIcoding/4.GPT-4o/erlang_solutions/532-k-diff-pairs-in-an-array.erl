-module(solution).
-export([find_pairs/2]).

-spec find_pairs([integer()], integer()) -> integer().
find_pairs(Nums, K) when K >= 0 ->
    find_pairs_helper(Nums, K, #{}, 0).

find_pairs_helper([], _, _, Count) -> 
    Count;
find_pairs_helper([Head | Tail], K, Seen, Count) ->
    case maps:find(Head - K, Seen) of
        {ok, _} -> find_pairs_helper(Tail, K, maps:put(Head, true, Seen), Count + 1);
        error -> 
            case K > 0 of
                true -> find_pairs_helper(Tail, K, maps:put(Head, true, Seen), Count);
                false -> find_pairs_helper(Tail, K, maps:put(Head, true, Seen), Count)
            end
    end.
