-module(solution).
-export([min_time_to_type/1]).

-spec min_time_to_type(Word :: unicode:unicode_binary()) -> integer().
min_time_to_type(Word) ->
    CharList = unicode:characters_to_list(Word),

    {_FinalChar, TotalTime} = lists:foldl(
        fun(TargetChar, {CurrentChar, AccTime}) ->
            Diff = abs(TargetChar - CurrentChar),
            MoveTime = min(Diff, 26 - Diff),
            NewAccTime = AccTime + MoveTime + 1,
            {TargetChar, NewAccTime}
        end,
        {'a', 0},
        CharList
    ),
    TotalTime.