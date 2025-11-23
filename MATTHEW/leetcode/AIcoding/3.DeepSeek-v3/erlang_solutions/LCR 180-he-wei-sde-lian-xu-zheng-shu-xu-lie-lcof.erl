-spec file_combination(Target :: integer()) -> [[integer()]].
file_combination(Target) ->
    Ans = [],
    file_combination(1, Target, Ans).

file_combination(Start, Target, Ans) when Start > Target div 2 + 1 ->
    lists:reverse(Ans);
file_combination(Start, Target, Ans) ->
    case find_sequence(Start, Target, 0, []) of
        {ok, Seq} -> file_combination(Start + 1, Target, [Seq|Ans]);
        not_found -> file_combination(Start + 1, Target, Ans)
    end.

find_sequence(Current, Target, Sum, Seq) when Sum + Current > Target ->
    not_found;
find_sequence(Current, Target, Sum, Seq) when Sum + Current =:= Target ->
    {ok, lists:reverse([Current|Seq])};
find_sequence(Current, Target, Sum, Seq) ->
    find_sequence(Current + 1, Target, Sum + Current, [Current|Seq]).