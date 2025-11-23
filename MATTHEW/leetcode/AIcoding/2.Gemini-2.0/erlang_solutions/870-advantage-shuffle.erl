-module(advantage_shuffle).
-export([advantage_shuffle/1]).

advantage_shuffle(A) ->
    B = lists:sort(A),
    N = length(A),
    {Perm, _} = lists:foldl(
        fun(X, {P, SortedB}) ->
            case find_greater(X, SortedB) of
                {true, Index} ->
                    {P ++ [lists:nth(Index, SortedB)], lists:delete(lists:nth(Index, SortedB), SortedB)};
                false ->
                    {P ++ [hd(SortedB)], tl(SortedB)}
            end
        end,
        {[], lists:sort(A)},
        A
    ),
    Perm.

find_greater(X, SortedB) ->
    find_greater(X, SortedB, 1, length(SortedB)).

find_greater(_, [], _, _) ->
    {false, -1};
find_greater(X, SortedB, Low, High) ->
    if
        Low > High ->
            {false, -1};
        true ->
            Mid = (Low + High) div 2,
            MidVal = lists:nth(Mid, SortedB),
            if
                MidVal > X ->
                    if
                        Mid =:= Low ->
                            {true, Mid};
                        lists:nth(Mid - 1, SortedB) =< X ->
                            {true, Mid};
                        true ->
                            find_greater(X, SortedB, Low, Mid - 1)
                    else
                        find_greater(X, SortedB, Mid + 1, High)
                    end
            end
    end.