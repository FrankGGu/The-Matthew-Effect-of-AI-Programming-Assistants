-module(execution_of_all_suffix_instructions).
-export([exec_instructions/3]).

exec_instructions(N, StartPos, S) ->
    exec_instructions(N, StartPos, S, []).

exec_instructions(N, StartPos, S, Acc) ->
    Len = length(S),
    exec_instructions_helper(N, StartPos, S, 0, Len, Acc).

exec_instructions_helper(_N, _StartPos, _S, Len, Len, Acc) ->
    lists:reverse(Acc);
exec_instructions_helper(N, StartPos, S, StartIndex, Len, Acc) ->
    Result = execute_suffix(N, StartPos, lists:sublist(S, StartIndex + 1, Len - StartIndex)),
    exec_instructions_helper(N, StartPos, S, StartIndex + 1, Len, [Result | Acc]).

execute_suffix(N, [Row, Col], Instructions) ->
    execute_suffix_helper(N, [Row, Col], Instructions, 0).

execute_suffix_helper(N, [Row, Col], [], Count) ->
    Count;
execute_suffix_helper(N, [Row, Col], [H | T], Count) ->
    case H of
        $R ->
            NewCol = Col + 1;
            case NewCol < N of
                true ->
                    execute_suffix_helper(N, [Row, NewCol], T, Count + 1);
                false ->
                    Count
            end;
        $L ->
            NewCol = Col - 1;
            case NewCol >= 0 of
                true ->
                    execute_suffix_helper(N, [Row, NewCol], T, Count + 1);
                false ->
                    Count
            end;
        $U ->
            NewRow = Row - 1;
            case NewRow >= 0 of
                true ->
                    execute_suffix_helper(N, [NewRow, Col], T, Count + 1);
                false ->
                    Count
            end;
        $D ->
            NewRow = Row + 1;
            case NewRow < N of
                true ->
                    execute_suffix_helper(N, [NewRow, Col], T, Count + 1);
                false ->
                    Count
            end
    end.