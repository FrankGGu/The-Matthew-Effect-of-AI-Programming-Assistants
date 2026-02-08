-module(solution).
-export([combine_files/1]).

combine_files(Files) ->
    combine_files(Files, []).

combine_files([], Acc) ->
    lists:reverse(Acc);
combine_files([File | Rest], Acc) ->
    {ok, Content} = file:read_file(File),
    combine_files(Rest, [Content | Acc]).