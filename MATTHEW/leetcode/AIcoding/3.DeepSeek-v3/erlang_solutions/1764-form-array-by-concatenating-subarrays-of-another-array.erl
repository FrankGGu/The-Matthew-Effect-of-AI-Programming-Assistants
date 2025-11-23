-spec can_choose(Groups :: [[integer()]], Nums :: [integer()]) -> boolean().
can_choose(Groups, Nums) ->
    can_choose(Groups, Nums, 0).

can_choose([], _Nums, _Pos) -> true;
can_choose([Group | RestGroups], Nums, Pos) ->
    case find_subarray(Nums, Group, Pos) of
        -1 -> false;
        NewPos -> can_choose(RestGroups, Nums, NewPos + length(Group))
    end.

find_subarray(Nums, Group, Start) ->
    GroupLen = length(Group),
    NumsLen = length(Nums),
    case NumsLen - Start >= GroupLen of
        false -> -1;
        true ->
            case lists:sublist(Nums, Start + 1, GroupLen) =:= Group of
                true -> Start;
                false -> find_subarray(Nums, Group, Start + 1)
            end
    end.