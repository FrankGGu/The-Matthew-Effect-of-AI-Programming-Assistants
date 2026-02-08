-spec diff_ways_to_compute(Expression :: unicode:unicode_binary()) -> [integer()].
diff_ways_to_compute(Expression) ->
    case binary_to_list(Expression) of
        [] -> [];
        Str -> compute(Str)
    end.

compute(Str) ->
    case string:to_integer(Str) of
        {Num, []} -> [Num];
        _ ->
            lists:foldl(fun(I, Acc) ->
                case lists:nth(I, Str) of
                    Op when Op =:= $+; Op =:= $-; Op =:= $* ->
                        Left = compute(string:substr(Str, 1, I - 1)),
                        Right = compute(string:substr(Str, I + 1)),
                        lists:append(Acc, [apply_op(L, R, Op) || L <- Left, R <- Right])
                end
            end, [], lists:seq(1, length(Str)))
    end.

apply_op(L, R, $+) -> L + R;
apply_op(L, R, $-) -> L - R;
apply_op(L, R, $*) -> L * R.