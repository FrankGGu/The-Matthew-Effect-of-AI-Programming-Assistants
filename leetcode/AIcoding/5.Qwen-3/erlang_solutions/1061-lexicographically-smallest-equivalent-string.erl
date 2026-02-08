-module(lexicographically_smallest_equivalent_string).
-export([find_lexicographically_smallest_equivalent_string/3]).

find_lexicographically_smallest_equivalent_string(Original, Target, Switch) ->
    Parent = dict:from_list([{C, C} || C <- lists:seq($a, $z)]),
    lists:foreach(fun({O, T}) -> union(O, T, Parent) end, lists:zip(Original, Target)),
    [get_root(C, Parent) || C <- Original].

union(X, Y, Parent) ->
    XRoot = get_root(X, Parent),
    YRoot = get_root(Y, Parent),
    if
        XRoot < YRoot -> dict:update(YRoot, fun(_) -> XRoot end, Parent);
        true -> dict:update(XRoot, fun(_) -> YRoot end, Parent)
    end.

get_root(X, Parent) ->
    case dict:is_key(X, Parent) of
        true ->
            case dict:fetch(X, Parent) of
                X -> X;
                Root -> get_root(Root, Parent)
            end;
        false -> X
    end.