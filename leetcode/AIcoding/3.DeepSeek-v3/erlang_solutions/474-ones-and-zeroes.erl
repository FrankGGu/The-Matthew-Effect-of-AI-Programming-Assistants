-spec find_max_form(Strs :: [unicode:unicode_binary()], M :: integer(), N :: integer()) -> integer().
find_max_form(Strs, M, N) ->
    DP = lists:foldl(fun(_, Acc) -> 
                        [array:new([{size, N+1}, {default, 0}]) || _ <- lists:seq(1, M+1)]
                     end, [], lists:seq(1, M+1)),
    lists:foldl(fun(Str, AccDP) ->
                    {Zeros, Ones} = count_zeros_ones(Str),
                    lists:foldl(fun(I, DPAcc) ->
                        lists:foldl(fun(J, InnerDPAcc) ->
                            case (I >= Zeros andalso J >= Ones) of
                                true ->
                                    Prev = array:get(I - Zeros, array:get(J - Ones, InnerDPAcc)),
                                    Current = array:get(I, array:get(J, InnerDPAcc)),
                                    NewVal = max(Current, Prev + 1),
                                    array:set(I, array:set(J, NewVal, array:get(I, InnerDPAcc)), InnerDPAcc);
                                false ->
                                    InnerDPAcc
                            end
                        end, DPAcc, lists:seq(N, Ones, -1))
                    end, AccDP, lists:seq(M, Zeros, -1))
                end, DP, Strs),
    array:get(M, array:get(N, DP)).

count_zeros_ones(Str) ->
    Bin = unicode:characters_to_binary(Str),
    Zeros = byte_size(Bin) - length(binary:matches(Bin, <<"1">>)),
    Ones = byte_size(Bin) - Zeros,
    {Zeros, Ones}.