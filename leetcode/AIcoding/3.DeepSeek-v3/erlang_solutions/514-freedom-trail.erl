-module(solution).
-export([find_rotate_steps/2]).

find_rotate_steps(Ring, Key) ->
    RingList = binary_to_list(Ring),
    KeyList = binary_to_list(Key),
    Memo = maps:new(),
    {Result, _} = dfs(RingList, KeyList, 0, Memo),
    Result + length(KeyList).

dfs(Ring, [], _Pos, Memo) ->
    {0, Memo};
dfs(Ring, [H|T], Pos, Memo) ->
    case maps:find({Pos, H}, Memo) of
        {ok, Val} ->
            {Val, Memo};
        error ->
            Positions = find_char_positions(Ring, H),
            MinSteps = lists:foldl(
                fun(P, {CurrentMin, CurrentMemo}) ->
                    Steps = min(abs(P - Pos), length(Ring) - abs(P - Pos)),
                    {SubSteps, NewMemo} = dfs(Ring, T, P, CurrentMemo),
                    TotalSteps = Steps + SubSteps,
                    if 
                        TotalSteps < CurrentMin -> {TotalSteps, NewMemo};
                        true -> {CurrentMin, NewMemo}
                    end
                end,
                {infinity, Memo},
                Positions
            ),
            {MinVal, NewMemo} = MinSteps,
            {MinVal, maps:put({Pos, H}, MinVal, NewMemo)}
    end.

find_char_positions(Ring, Char) ->
    lists:foldl(
        fun({C, Idx}, Acc) ->
            case C =:= Char of
                true -> [Idx | Acc];
                false -> Acc
            end
        end,
        [],
        lists:zip(Ring, lists:seq(0, length(Ring) - 1))
    ).