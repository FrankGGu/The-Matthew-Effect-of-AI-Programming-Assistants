-spec divide_players(Skill :: [integer()]) -> integer().
divide_players(Skill) ->
    Sorted = lists:sort(Skill),
    N = length(Skill),
    K = N div 2,
    Target = lists:sum(Skill) div K,
    divide_players(Sorted, Target, 0).

divide_players([], _, Acc) -> Acc;
divide_players([H | T], Target, Acc) ->
    case lists:member(Target - H, T) of
        true ->
            NewT = lists:delete(Target - H, T),
            divide_players(NewT, Target, Acc + H * (Target - H));
        false ->
            -1
    end.