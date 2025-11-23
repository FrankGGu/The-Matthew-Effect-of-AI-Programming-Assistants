-module(solution).
-export([create_min_num/1]).

create_min_num(DI) ->
    create_min_num(DI, 1, [], []).

create_min_num([], _Num, _Stack, Result) ->
    lists:reverse(Result ++ lists:reverse(_Stack));
create_min_num([H | T], Num, Stack, Result) ->
    case H of
        $D ->
            create_min_num(T, Num + 1, [Num | Stack], Result);
        $I ->
            create_min_num(T, Num + 1, [], [Num | Result])
    end.