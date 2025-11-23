-spec diff_ways_to_compute(Expression :: unicode:unicode_binary()) -> [integer()].
diff_ways_to_compute(Expression) ->
    diff_ways_to_compute(string:to_list(Expression)).

diff_ways_to_compute([]) -> [];
diff_ways_to_compute([H | T]) when H >= $0, H =< $9 -> 
    diff_ways_to_compute(T);
diff_ways_to_compute([Op | Rest]) when Op == $+ orelse Op == $- orelse Op == $* ->
    LeftResults = diff_ways_to_compute(Rest),
    RightResults = diff_ways_to_compute(Rest),
    compute(LeftResults, Op, RightResults).

compute([], _, _) -> [];
compute(_, _, []) -> [];
compute([L | Left], Op, [R | Right]) ->
    case Op of
        $+ -> [L + R | compute(Left, Op, Right)];
        $- -> [L - R | compute(Left, Op, Right)];
        $* -> [L * R | compute(Left, Op, Right)]
    end.
