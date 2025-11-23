-spec find_lex_smallest_string(S :: unicode:unicode_binary(), A :: integer()) -> unicode:unicode_binary().
find_lex_smallest_string(S, A) ->
    SList = binary_to_list(S),
    Min = lists:min(SList),
    find_min(SList, A, SList, Min).

find_min(Current, A, Original, Min) ->
    case apply_operations(Current, A, Min) of
        Current -> list_to_binary(Current);
        Next -> find_min(Next, A, Original, Min)
    end.

apply_operations(S, A, Min) ->
    lists:foldl(fun(I, Acc) ->
        Char = lists:nth(I, Acc),
        NewChar = ((Char - $0 + A) rem 10) + $0,
        if
            NewChar < Char -> 
                NewS = lists:sublist(Acc, I - 1) ++ [NewChar] ++ lists:nthtail(I, Acc),
                if
                    NewS < Acc -> NewS;
                    true -> Acc
                end;
            true -> Acc
        end
    end, S, lists:seq(1, length(S))).