-module(solution).
-export([split/2]).

split(Str, Separator) ->
    split(Str, Separator, []).

split([], _, Acc) ->
    lists:reverse(Acc);
split(Str, Separator, Acc) ->
    case string:split(Str, Separator, leading) of
        {Part, Rest} ->
            split(Rest, Separator, [Part | Acc]);
        nomatch ->
            lists:reverse([Str | Acc])
    end.