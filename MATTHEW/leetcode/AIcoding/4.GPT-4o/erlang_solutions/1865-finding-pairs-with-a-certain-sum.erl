-module(solution).
-export([find_pairs/2]).

find_pairs(List, Target) ->
    Pairs = sets:new(),
    Seen = sets:new(),
    find_pairs_helper(List, Target, Seen, Pairs).

find_pairs_helper([], _Target, _Seen, Pairs) ->
    sets:to_list(Pairs);
find_pairs_helper([H | T], Target, Seen, Pairs) ->
    Complement = Target - H,
    case sets:is_element(Complement, Seen) of
        true -> 
            NewPair = {min(H, Complement), max(H, Complement)},
            find_pairs_helper(T, Target, sets:add(H, Seen), sets:add(NewPair, Pairs));
        false -> 
            find_pairs_helper(T, Target, sets:add(H, Seen), Pairs)
    end.