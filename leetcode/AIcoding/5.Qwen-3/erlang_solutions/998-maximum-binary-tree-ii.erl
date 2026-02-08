-module(maximum_binary_tree_ii).
-export([construct/1]).

construct([]) ->
    null;
construct(List) ->
    {MaxVal, Index} = find_max(List),
    #{
        val => MaxVal,
        left => construct(lists:sublist(List, 1, Index)),
        right => construct(lists:sublist(List, Index + 1, length(List) - Index - 1))
    }.

find_max(List) ->
    find_max(List, 0, 0, 0).

find_max([], _Index, _MaxVal, _MaxIndex) ->
    {0, 0};
find_max([H | T], Index, CurrentMax, CurrentIndex) ->
    if
        H > CurrentMax ->
            find_max(T, Index + 1, H, Index);
        true ->
            find_max(T, Index + 1, CurrentMax, CurrentIndex)
    end.