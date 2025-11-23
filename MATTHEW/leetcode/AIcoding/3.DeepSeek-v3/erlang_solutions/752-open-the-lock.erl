-module(solution).
-export([open_lock/2]).

open_lock(Deadends, Target) ->
    DeadSet = sets:from_list(Deadends),
    case sets:is_element("0000", DeadSet) of
        true -> -1;
        false ->
            Queue = queue:in({"0000", 0}, queue:new()),
            Visited = sets:add_element("0000", DeadSet),
            bfs(Queue, Visited, Target)
    end.

bfs(Queue, Visited, Target) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Current, Steps}}, Q} ->
            case Current =:= Target of
                true -> Steps;
                false ->
                    NewQueue = lists:foldl(fun(Next, Acc) ->
                        case sets:is_element(Next, Visited) of
                            false ->
                                NewVisited = sets:add_element(Next, Visited),
                                queue:in({Next, Steps + 1}, Acc);
                            true -> Acc
                        end
                    end, Q, get_next(Current)),
                    bfs(NewQueue, Visited, Target)
            end
    end.

get_next(Current) ->
    NextList = [],
    lists:foldl(fun(I, Acc) ->
        Digit = lists:nth(I, Current),
        DigitInt = Digit - $0,
        [Next1, Next2] = [(DigitInt + 1) rem 10, (DigitInt + 9) rem 10],
        NextStr1 = replace_char_at(Current, I, Next1 + $0),
        NextStr2 = replace_char_at(Current, I, Next2 + $0),
        [NextStr1, NextStr2 | Acc]
    end, NextList, lists:seq(1, 4)).

replace_char_at(Str, Pos, Char) ->
    {Prefix, [_ | Suffix]} = lists:split(Pos - 1, Str),
    Prefix ++ [Char | Suffix].