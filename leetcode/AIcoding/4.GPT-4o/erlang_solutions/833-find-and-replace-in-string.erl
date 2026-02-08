-module(solution).
-export([find_replace_string/3]).

find_replace_string(S, Indices, Sources, Targets) ->
    find_replace_string(S, Indices, Sources, Targets, []).

find_replace_string(S, [], _, _, Acc) ->
    lists:reverse(Acc) ++ [S];
find_replace_string(S, [I | Is], [Src | Srcs], [Tgt | Tgts], Acc) ->
    {Prefix, Rest} = lists:split(I, S),
    case lists:prefix(Src, Rest) of
        true -> 
            NewS = Prefix ++ Tgt ++ lists:drop(length(Src), Rest),
            find_replace_string(NewS, Is, Srcs, Tgts, [NewS | Acc]);
        false -> 
            find_replace_string(S, Is, Srcs, Tgts, [S | Acc])
    end.