-spec minimize_result(Expression :: unicode:unicode_binary()) -> unicode:unicode_binary().
minimize_result(Expression) ->
    {A, B} = binary:split(Expression, <<"+">>),
    LenA = byte_size(A),
    LenB = byte_size(B),
    Min = infinity,
    Result = <<>>,
    {MinResult, _} = lists:foldl(fun(I, {CurrentMin, CurrentResult}) ->
        lists:foldl(fun(J, {InnerMin, InnerResult}) ->
            A1 = case I of 0 -> 1; _ -> binary_to_integer(binary:part(A, 0, I)) end,
            A2 = binary_to_integer(binary:part(A, I, LenA - I)),
            B1 = binary_to_integer(binary:part(B, 0, J)),
            B2 = case J of LenB -> 1; _ -> binary_to_integer(binary:part(B, J, LenB - J)) end,
            Value = A1 * (A2 + B1) * B2,
            if
                Value < InnerMin ->
                    NewA = case I of 0 -> <<>>; _ -> binary:part(A, 0, I) end,
                    NewB = case J of LenB -> <<>>; _ -> binary:part(B, J, LenB - J) end,
                    NewExpr = <<NewA/binary, "(", (binary:part(A, I, LenA - I))/binary, "+", (binary:part(B, 0, J))/binary, ")", NewB/binary>>,
                    {Value, NewExpr};
                true ->
                    {InnerMin, InnerResult}
            end
        end, CurrentMin, CurrentResult) end, lists:seq(0, LenB), {CurrentMin, CurrentResult})
    end, {Min, Result}, lists:seq(0, LenA)),
    MinResult.