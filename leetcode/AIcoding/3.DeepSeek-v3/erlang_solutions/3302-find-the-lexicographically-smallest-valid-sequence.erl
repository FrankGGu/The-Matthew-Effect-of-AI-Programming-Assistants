-spec construct_sequence(n :: integer()) -> [integer()].
construct_sequence(N) ->
    case N of
        1 -> [1];
        2 -> [1, 2];
        3 -> [3, 1, 2, 1, 3, 2];
        _ -> construct(N, [1], maps:from_list([{1, true}]), 2)
    end.

construct(N, Seq, Used, Next) ->
    case length(Seq) =:= 2 * N - 1 of
        true -> lists:reverse(Seq);
        false ->
            case Next > N of
                true ->
                    Last = hd(Seq),
                    case Last + 1 =< N andalso not maps:is_key(Last + 1, Used) of
                        true -> construct(N, [Last + 1 | Seq], maps:put(Last + 1, true, Used), Next);
                        false ->
                            case Last - 1 >= 1 andalso not maps:is_key(Last - 1, Used) of
                                true -> construct(N, [Last - 1 | Seq], maps:put(Last - 1, true, Used), Next);
                                false -> backtrack(N, Seq, Used, Next)
                            end
                    end;
                false ->
                    case not maps:is_key(Next, Used) of
                        true -> construct(N, [Next | Seq], maps:put(Next, true, Used), Next + 1);
                        false -> construct(N, Seq, Used, Next + 1)
                    end
            end
    end.

backtrack(N, [H | T], Used, Next) ->
    case H =:= Next - 1 of
        true -> backtrack(N, T, maps:remove(H, Used), Next);
        false ->
            NewUsed = maps:remove(H, Used),
            case H + 1 =< N andalso not maps:is_key(H + 1, NewUsed) of
                true -> construct(N, [H + 1 | T], maps:put(H + 1, true, NewUsed), Next);
                false ->
                    case H - 1 >= 1 andalso not maps:is_key(H - 1, NewUsed) of
                        true -> construct(N, [H - 1 | T], maps:put(H - 1, true, NewUsed), Next);
                        false -> backtrack(N, T, NewUsed, Next)
                    end
            end
    end.