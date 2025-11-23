-module(solution).
-export([find_replace_string/4]).

find_replace_string(S, Indices, Sources, Targets) ->
    {SortedIndices, SortedSources, SortedTargets} = lists:unzip3(lists:sort(lists:zip3(Indices, Sources, Targets))),
    replace(S, SortedIndices, SortedSources, SortedTargets, 0, []).

replace(S, [], [], [], _Index, Acc) ->
    lists:reverse(Acc) ++ S;
replace([_ | Rest] = S, [I | Is], [Src | Srcs], [Tgt | Tgts], Index, Acc) when I == Index ->
    SrcLen = length(Src),
    case lists:prefix(Src, S) of
        true ->
            NewAcc = lists:reverse(Tgt, Acc),
            NewS = lists:nthtail(SrcLen, S),
            replace(NewS, Is, Srcs, Tgts, Index + SrcLen, NewAcc);
        false ->
            replace(Rest, [I | Is], [Src | Srcs], [Tgt | Tgts], Index + 1, [hd(S) | Acc])
    end;
replace([H | Rest], Indices, Sources, Targets, Index, Acc) ->
    replace(Rest, Indices, Sources, Targets, Index + 1, [H | Acc]).