-spec execute_instructions(N :: integer(), StartPos :: [integer()], S :: unicode:unicode_binary()) -> [integer()].
execute_instructions(N, StartPos, S) ->
    [execute_instruction(N, StartPos, string:slice(S, I)) || I <- lists:seq(0, string:length(S) - 1)].

execute_instruction(N, [Row, Col], S) ->
    execute_instruction(N, Row, Col, S, 0).

execute_instruction(_, _, _, [], Count) -> Count;
execute_instruction(N, Row, Col, [H | T], Count) ->
    case H of
        $L when Col > 0 -> execute_instruction(N, Row, Col - 1, T, Count + 1);
        $R when Col < N - 1 -> execute_instruction(N, Row, Col + 1, T, Count + 1);
        $U when Row > 0 -> execute_instruction(N, Row - 1, Col, T, Count + 1);
        $D when Row < N - 1 -> execute_instruction(N, Row + 1, Col, T, Count + 1);
        _ -> Count
    end.