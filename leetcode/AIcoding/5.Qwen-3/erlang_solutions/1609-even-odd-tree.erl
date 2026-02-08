-module(even_odd_tree).
-export([is_even_odd_tree/1]).

is_even_odd_tree(nil) -> true;
is_even_odd_tree(Root) ->
    is_even_odd_tree(Root, 0, []).

is_even_odd_tree(nil, _, _) -> true;
is_even_odd_tree(#{} = Node, Level, Levels) ->
    Value = maps:get(value, Node),
    case lists:nth(Level + 1, Levels, undefined) of
        undefined ->
            case Level rem 2 of
                0 ->
                    if Value rem 2 /= 0 -> false;
                       true -> ok end,
                    NewLevels = lists:append(Levels, [Value]),
                    Children = maps:get(children, Node, []),
                    check_children(Children, Level + 1, NewLevels);
                1 ->
                    if Value rem 2 == 0 -> false;
                       true -> ok end,
                    NewLevels = lists:append(Levels, [Value]),
                    Children = maps:get(children, Node, []),
                    check_children(Children, Level + 1, NewLevels)
            end;
        PrevVal ->
            case Level rem 2 of
                0 ->
                    if Value rem 2 /= 0 -> false;
                       Value >= PrevVal -> false;
                       true -> ok end,
                    NewLevels = lists:sublist(Levels, Level) ++ [Value],
                    Children = maps:get(children, Node, []),
                    check_children(Children, Level + 1, NewLevels);
                1 ->
                    if Value rem 2 == 0 -> false;
                       Value <= PrevVal -> false;
                       true -> ok end,
                    NewLevels = lists:sublist(Levels, Level) ++ [Value],
                    Children = maps:get(children, Node, []),
                    check_children(Children, Level + 1, NewLevels)
            end
    end.

check_children([], _, _) -> true;
check_children([Child | Rest], Level, Levels) ->
    case is_even_odd_tree(Child, Level, Levels) of
        true -> check_children(Rest, Level, Levels);
        false -> false
    end.