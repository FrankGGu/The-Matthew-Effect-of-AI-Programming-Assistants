-module(small_subsequence).
-export([last_subsequence/1]).

last_subsequence(S) ->
    Stack = [],
    Visited = sets:new(),
    LastIndex = maps:from_list([{Char, Pos} || {Pos, Char} <- lists:enumerate(S)]),
    lists:foldl(fun(Char, {Stack, Visited}) ->
        if
            sets:is_element(Char, Visited) -> {Stack, Visited};
            true ->
                case Stack of
                    [] -> {[Char | Stack], sets:add_element(Char, Visited)};
                    _ ->
                        [Top | Rest] = Stack,
                        if
                            Char < Top ->
                                {NewStack, NewVisited} = pop_stack(Top, Rest, Char, Visited, LastIndex),
                                {NewStack, NewVisited};
                            true ->
                                {[Char | Stack], sets:add_element(Char, Visited)}
                        end
                end
        end
    end, {Stack, Visited}, S).

pop_stack(_, [], Char, Visited, _) ->
    {[Char | []], sets:add_element(Char, Visited)};
pop_stack(Top, Rest, Char, Visited, LastIndex) ->
    case LastIndex of
        Map when maps:get(Top, Map, -1) > 0 ->
            if
                Char < Top ->
                    pop_stack(Rest, lists:tl(Rest), Char, sets:del_element(Top, Visited), LastIndex);
                true ->
                    {[Top | Rest], Visited}
            end;
        _ ->
            {[Top | Rest], Visited}
    end.