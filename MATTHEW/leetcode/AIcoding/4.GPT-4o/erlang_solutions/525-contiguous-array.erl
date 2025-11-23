-module(solution).
-export([find_max_length/1]).

-spec find_max_length([integer()]) -> integer().
find_max_length(Nums) ->
    find_max_length(Nums, 0, 0, #{}, 0).

find_max_length([], _, _, _, MaxLen) -> MaxLen;
find_max_length([H | T], Balance, Index, Map, MaxLen) ->
    NewBalance = if
                    H == 1 -> Balance + 1;
                    true -> Balance - 1
                end,
    case maps:find(NewBalance, Map) of
        {ok, PreviousIndex} -> 
            NewMaxLen = max(MaxLen, Index - PreviousIndex),
            find_max_length(T, NewBalance, Index + 1, Map, NewMaxLen);
        error -> 
            find_max_length(T, NewBalance, Index + 1, maps:put(NewBalance, Index, Map), MaxLen)
    end.
