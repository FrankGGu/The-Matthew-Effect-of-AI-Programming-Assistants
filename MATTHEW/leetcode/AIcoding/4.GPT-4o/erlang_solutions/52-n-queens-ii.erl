%% -spec total_n_queens(N :: integer()) -> integer().
total_n_queens(N) ->
    total_n_queens(N, [], 0).

-spec total_n_queens(N :: integer(), Current :: [integer()], Count :: integer()) -> integer().
total_n_queens(0, _, Count) -> Count;
total_n_queens(N, Current, Count) when N > 0 ->
    lists:foldl(fun(Row, Acc) -> 
                    case valid_placement(Row, Current) of
                        true -> total_n_queens(N - 1, [Row | Current], Acc + 1);
                        false -> Acc
                    end
                end, Count, lists:seq(1, N)).

valid_placement(Row, Current) ->
    lists:all(fun(OtherRow) -> 
                  Row /= OtherRow andalso
                  abs(Row - OtherRow) =/= abs(length(Current) - length([OtherRow | Current])) 
              end, Current).
