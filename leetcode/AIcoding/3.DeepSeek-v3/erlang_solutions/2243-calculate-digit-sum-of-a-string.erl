-spec digit_sum(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
digit_sum(S, K) when byte_size(S) =< K ->
    S;
digit_sum(S, K) ->
    Groups = group_string(S, K),
    NewS = lists:foldl(fun(Group, Acc) ->
        Sum = lists:sum([Char - $0 || Char <- Group]),
        Acc ++ integer_to_list(Sum)
    end, "", Groups),
    digit_sum(NewS, K).

group_string(S, K) ->
    group_string(S, K, []).

group_string(S, K, Acc) when byte_size(S) =< K ->
    lists:reverse([S | Acc]);
group_string(S, K, Acc) ->
    <<Group:K/binary, Rest/binary>> = S,
    group_string(Rest, K, [Group | Acc]).