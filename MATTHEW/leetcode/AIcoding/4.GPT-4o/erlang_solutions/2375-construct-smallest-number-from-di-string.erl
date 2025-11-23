-module(solution).
-export([smallestNumber/1]).

smallestNumber(D) ->
    N = length(D) + 1,
    {Res, _} = smallest_number(D, N, [], 1),
    lists:flatten(lists:reverse(Res)).

smallest_number([], N, Acc, Curr) ->
    {lists:append(Acc, [Curr]), Curr};
smallest_number([H | T], N, Acc, Curr) ->
    case H of
        $I ->
            smallest_number(T, N, [Curr | Acc], Curr + 1);
        $D ->
            {NewAcc, NewCurr} = smallest_number(T, N, Acc, Curr + 1),
            {NewAcc, lists:append([NewCurr | Acc])}
    end.