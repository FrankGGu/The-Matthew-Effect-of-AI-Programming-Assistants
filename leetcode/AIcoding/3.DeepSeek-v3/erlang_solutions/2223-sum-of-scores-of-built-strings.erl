-spec sum_scores(S :: unicode:unicode_binary()) -> integer().
sum_scores(S) ->
    N = byte_size(S),
    Z = array:new(N, [{default, 0}]),
    {Z1, _} = compute_z_array(S, 1, 0, Z),
    sum_z_array(Z1, 0, 0).

compute_z_array(S, K, R, Z) when K >= byte_size(S) ->
    {Z, R};
compute_z_array(S, K, R, Z) ->
    case K > R of
        true ->
            {R1, Z1} = compare(S, 0, K, R, Z),
            compute_z_array(S, K + 1, R1, Z1);
        false ->
            K1 = K - 1,
            Zval = array:get(K1, Z),
            if
                Zval < R - K + 1 ->
                    Z2 = array:set(K, Zval, Z),
                    compute_z_array(S, K + 1, R, Z2);
                true ->
                    {R2, Z3} = compare(S, R - K + 1, R + 1, R, Z),
                    Z4 = array:set(K, R2 - K, Z3),
                    compute_z_array(S, K + 1, R2, Z4)
            end
    end.

compare(S, I, J, R, Z) ->
    N = byte_size(S),
    case J < N andalso binary:at(S, I) =:= binary:at(S, J) of
        true ->
            compare(S, I + 1, J + 1, R, Z);
        false ->
            {J - 1, array:set(I, J - I, Z)}
    end.

sum_z_array(Z, I, Sum) when I >= array:size(Z) ->
    Sum + array:size(Z);
sum_z_array(Z, I, Sum) ->
    sum_z_array(Z, I + 1, Sum + array:get(I, Z)).