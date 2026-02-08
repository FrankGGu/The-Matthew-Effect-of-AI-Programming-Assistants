-spec min_jump(Init :: [integer()]) -> integer().
min_jump(Init) ->
    N = length(Init),
    Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
    Queue = queue:from_list([{0, 0}]),
    min_jump_loop(Init, Queue, Visited, N).

min_jump_loop(Init, Queue, Visited, N) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Pos, Steps}}, Q} ->
            if
                Pos >= N -> Steps;
                true ->
                    Jump = lists:nth(Pos + 1, Init),
                    NewVisited1 = array:set(Pos, true, Visited),
                    Q1 = case Pos + Jump >= N of
                        true -> queue:in({Pos + Jump, Steps + 1}, Q);
                        false ->
                            case array:get(Pos + Jump, NewVisited1) of
                                false -> queue:in({Pos + Jump, Steps + 1}, Q);
                                true -> Q
                            end
                    end,
                    Q2 = case Pos - 1 >= 0 of
                        true ->
                            case array:get(Pos - 1, NewVisited1) of
                                false -> queue:in({Pos - 1, Steps + 1}, Q1);
                                true -> Q1
                            end;
                        false -> Q1
                    end,
                    min_jump_loop(Init, Q2, NewVisited1, N)
            end
    end.