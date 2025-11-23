-spec max_palindromes(S :: unicode:unicode_binary(), K :: integer()) -> integer().
max_palindromes(S, K) ->
    N = byte_size(S),
    DP = array:new([{size, N + 1}, {default, 0}]),
    IsPal = array:new([{size, N}, {default, array:new([{size, N}, {default, false}])}]),
    lists:foreach(
        fun(I) ->
            lists:foreach(
                fun(J) ->
                    case I =< J of
                        true ->
                            case I == J of
                                true ->
                                    array:set(I, array:set(J, true, array:get(I, IsPal)), IsPal;
                                false ->
                                    case J == I + 1 of
                                        true ->
                                            case binary:at(S, I) == binary:at(S, J) of
                                                true ->
                                                    array:set(I, array:set(J, true, array:get(I, IsPal)), IsPal);
                                                false ->
                                                    array:set(I, array:set(J, false, array:get(I, IsPal)), IsPal)
                                            end;
                                        false ->
                                            case (binary:at(S, I) == binary:at(S, J)) andalso array:get(I + 1, array:get(J - 1, IsPal)) of
                                                true ->
                                                    array:set(I, array:set(J, true, array:get(I, IsPal)), IsPal);
                                                false ->
                                                    array:set(I, array:set(J, false, array:get(I, IsPal)), IsPal
                                            end
                                    end
                            end;
                        false ->
                            IsPal
                    end
                end,
                lists:seq(0, N - 1)
            )
        end,
        lists:seq(0, N - 1)
    ),
    lists:foreach(
        fun(I) ->
            DP1 = case I == 0 of
                true -> DP;
                false -> array:set(I, array:get(I - 1, DP), DP)
            end,
            lists:foreach(
                fun(J) ->
                    case I >= J of
                        false ->
                            case (J - I + 1 >= K) andalso array:get(I, array:get(J, IsPal)) of
                                true ->
                                    Prev = case I == 0 of
                                        true -> 0;
                                        false -> array:get(I - 1, DP)
                                    end,
                                    array:set(J, max(array:get(J, DP1), Prev + 1), DP1;
                                false ->
                                    DP1
                            end;
                        true ->
                            DP1
                    end
                end,
                lists:seq(0, N - 1)
            )
        end,
        lists:seq(0, N - 1)
    ),
    array:get(N - 1, DP).