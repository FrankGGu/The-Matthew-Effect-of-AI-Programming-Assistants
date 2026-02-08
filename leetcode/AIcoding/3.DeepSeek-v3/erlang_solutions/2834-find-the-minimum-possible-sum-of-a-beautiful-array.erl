-spec min_possible_sum(N :: integer(), Target :: integer()) -> integer().
min_possible_sum(N, Target) ->
    Sum = 0,
    Used = sets:new(),
    min_possible_sum(N, Target, Sum, Used, 1).

min_possible_sum(0, _Target, Sum, _Used, _Next) ->
    Sum;
min_possible_sum(N, Target, Sum, Used, Next) ->
    case sets:is_element(Next, Used) of
        true ->
            min_possible_sum(N, Target, Sum, Used, Next + 1);
        false ->
            NewSum = Sum + Next,
            NewUsed = sets:add_element(Next, Used),
            case Next * 2 - Target >= 1 of
                true ->
                    Forbidden = Next * 2 - Target,
                    NewUsed2 = sets:add_element(Forbidden, NewUsed),
                    min_possible_sum(N - 1, Target, NewSum, NewUsed2, Next + 1);
                false ->
                    min_possible_sum(N - 1, Target, NewSum, NewUsed, Next + 1)
            end
    end.