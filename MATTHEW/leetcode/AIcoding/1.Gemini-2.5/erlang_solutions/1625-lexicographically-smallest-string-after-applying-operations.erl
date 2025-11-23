-module(solution).
-export([findLexSmallestString/3]).

apply_add_a(S, A) ->
    lists:map(fun({Char, Index}) ->
                  if (Index rem 2) == 1 -> %% Odd index (0-indexed)
                      Digit = Char - $0,
                      NewDigit = (Digit + A) rem 10,
                      NewDigit + $0;
                  true -> %% Even index
                      Char
                  end
              end, lists:zip(S, lists:seq(0, length(S)-1))).

apply_rotate_b(S, B) ->
    Len = length(S),
    RotateAmount = B rem Len,
    {Head, Tail} = lists:split(Len - RotateAmount, S),
    Tail ++ Head.

findLexSmallestString(S, A, B) ->
    % Convert input string (binary) to list of characters for easier manipulation
    S_list = string:to_list(S),

    % Initialize queue for BFS
    Q = queue:new(),
    Q1 = queue:in(S_list, Q),

    % Initialize visited set
    Visited = gb_sets:add(S_list, gb_sets:empty()),

    % Initialize min_string with the starting string
    MinString = S_list,

    % Start BFS
    bfs(Q1, Visited, MinString, A, B).

bfs(Q, Visited, MinString, A, B) ->
    case queue:out(Q) of
        {{value, CurrentString}, Q_rest} ->
            % Update MinString if CurrentString is lexicographically smaller
            NewMinString = if CurrentString < MinString -> CurrentString;
                           true -> MinString
                           end,

            % Apply add_a operation
            NextString_Add = apply_add_a(CurrentString, A),
            {Q_after_add, Visited_after_add} =
                if not gb_sets:is_element(NextString_Add, Visited) ->
                    {queue:in(NextString_Add, Q_rest), gb_sets:add(NextString_Add, Visited)};
                true ->
                    {Q_rest, Visited}
                end,

            % Apply rotate_b operation
            NextString_Rotate = apply_rotate_b(CurrentString, B),
            {Q_after_rotate, Visited_after_rotate} =
                if not gb_sets:is_element(NextString_Rotate, Visited_after_add) ->
                    {queue:in(NextString_Rotate, Q_after_add), gb_sets:add(NextString_Rotate, Visited_after_add)};
                true ->
                    {Q_after_add, Visited_after_add}
                end,

            % Continue BFS
            bfs(Q_after_rotate, Visited_after_rotate, NewMinString, A, B);
        {empty, _} ->
            % Queue is empty, BFS finished. Convert min_string back to binary string.
            string:from_list(MinString)
    end.