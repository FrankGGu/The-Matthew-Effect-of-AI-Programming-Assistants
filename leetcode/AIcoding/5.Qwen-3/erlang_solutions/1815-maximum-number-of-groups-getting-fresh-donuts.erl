-module(max_groups_fresh_donuts).
-export([maxGroups/1]).

maxGroups(Counts) ->
    maxGroups(Counts, 0, 0, 0).

maxGroups([], _, _, Acc) ->
    Acc;
maxGroups([C | Cs], Index, GroupSize, Acc) ->
    if
        C == 0 ->
            maxGroups(Cs, Index + 1, GroupSize, Acc);
        true ->
            NewGroupSize = GroupSize + 1,
            NewAcc = if
                NewGroupSize > 0 andalso (Index + 1) rem NewGroupSize == 0 ->
                    Acc + 1;
                true ->
                    Acc
            end,
            maxGroups(Cs, Index + 1, NewGroupSize, NewAcc)
    end.