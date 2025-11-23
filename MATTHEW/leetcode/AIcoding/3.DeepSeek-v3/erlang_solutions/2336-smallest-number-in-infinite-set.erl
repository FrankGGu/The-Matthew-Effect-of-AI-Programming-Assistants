-module(smallest_infinite_set).
-export([init/0, popSmallest/1, addBack/2]).

init() ->
    {1, sets:new()}.

popSmallest({Current, Set}) ->
    case sets:is_empty(Set) of
        true ->
            {Current, {Current + 1, Set}};
        false ->
            [Smallest | _] = lists:sort(sets:to_list(Set)),
            NewSet = sets:del_element(Smallest, Set),
            {Smallest, {Current, NewSet}}
    end.

addBack(Num, {Current, Set}) ->
    if
        Num < Current ->
            case sets:is_element(Num, Set) of
                false -> {Current, sets:add_element(Num, Set)};
                true -> {Current, Set}
            end;
        true -> {Current, Set}
    end.