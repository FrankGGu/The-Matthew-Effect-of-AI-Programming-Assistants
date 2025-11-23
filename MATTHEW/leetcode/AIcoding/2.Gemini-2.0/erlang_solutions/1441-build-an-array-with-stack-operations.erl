-module(build_array).
-export([buildArray/2]).

buildArray(Target, N) ->
    buildArrayHelper(Target, 1, []).

buildArrayHelper([], _, Acc) ->
    lists:reverse(Acc);
buildArrayHelper([H|T], Curr, Acc) ->
    if
        H == Curr ->
            buildArrayHelper(T, Curr + 1, [<<"Push">>|Acc]);
        H > Curr ->
            buildArrayHelper([H|T], Curr + 1, [<<"Push">>, <<"Pop">>|Acc]);
        true ->
            buildArrayHelper([H|T], Curr + 1, Acc)
    end.