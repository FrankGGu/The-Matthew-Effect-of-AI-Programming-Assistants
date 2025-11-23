-module(smallest_number).
-export([smallest_number/1]).

smallest_number(S) ->
    N = length(S) + 1,
    smallest_number_helper(S, 1, N, []).

smallest_number_helper([], Current, N, Acc) ->
    lists:reverse([Current | Acc]);
smallest_number_helper([$I | Rest], Current, N, Acc) ->
    smallest_number_i(Rest, Current, N, [Current | Acc]);
smallest_number_helper([$D | Rest], Current, N, Acc) ->
    smallest_number_d(Rest, Current, N, [Current | Acc]).

smallest_number_i(Rest, Current, N, Acc) ->
    NewCurrent = Current + 1,
    if NewCurrent > N ->
        lists:reverse(Acc)
    else
        case Rest of
            [] -> lists:reverse([NewCurrent | Acc]);
            [$I | _] -> smallest_number_i(Rest, NewCurrent, N, [NewCurrent | Acc]);
            [$D | _] -> smallest_number_d(Rest, NewCurrent, N, [NewCurrent | Acc])
        end
    end.

smallest_number_d(Rest, Current, N, Acc) ->
    NewCurrent = Current + 1,
    if NewCurrent > N ->
        lists:reverse(Acc)
    else
        case Rest of
            [] -> lists:reverse([NewCurrent | Acc]);
            [$I | _] -> smallest_number_i(Rest, NewCurrent, N, [NewCurrent | Acc]);
            [$D | _] -> smallest_number_d(Rest, NewCurrent, N, [NewCurrent | Acc])
        end
    end.

smallest_number_helper_i(Rest, Current, N, Acc, Stack) ->
    NewCurrent = Current + 1,
    if NewCurrent > N ->
        lists:reverse(Acc)
    else
        case Rest of
            [] ->
                NewAcc = lists:reverse(Stack) ++ Acc,
                lists:reverse([NewCurrent | NewAcc]);
            [$I | _] ->
                NewAcc = lists:reverse(Stack) ++ Acc,
                smallest_number_i(Rest, NewCurrent, N, [NewCurrent | NewAcc]);
            [$D | _] ->
                smallest_number_d(Rest, NewCurrent, N, [NewCurrent | Acc])
        end
    end.

smallest_number_helper_d(Rest, Current, N, Acc, Stack) ->
    NewCurrent = Current + 1,
    if NewCurrent > N ->
        lists:reverse(Acc)
    else
        case Rest of
            [] ->
                NewAcc = lists:reverse(Stack) ++ Acc,
                lists:reverse([NewCurrent | NewAcc]);
            [$I | _] ->
                NewAcc = lists:reverse(Stack) ++ Acc,
                smallest_number_i(Rest, NewCurrent, N, [NewCurrent | NewAcc]);
            [$D | _] ->
                smallest_number_d(Rest, NewCurrent, N, [NewCurrent | Acc])
        end
    end.