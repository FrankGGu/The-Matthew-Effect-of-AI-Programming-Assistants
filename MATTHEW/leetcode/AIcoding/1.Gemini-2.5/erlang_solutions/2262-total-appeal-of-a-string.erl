-module(solution).
-export([appeal_sum/1]).

-spec appeal_sum(S :: unicode:unicode_binary()) -> integer().
appeal_sum(S) ->
    CharList = unicode:characters_to_list(S),
    N = length(CharList),
    InitialLastSeen = lists:duplicate(26, -1),

    {TotalAppeal, _, _} = lists:foldl(
        fun(Char, {AccAppeal, LastSeenList, CurrentIndex}) ->
            CharOffset = Char - $a,
            PrevIdx = lists:nth(CharOffset + 1, LastSeenList),
            Contribution = (CurrentIndex - PrevIdx) * (N - CurrentIndex),
            NewAccAppeal = AccAppeal + Contribution,
            NewLastSeenList = lists:replace_nth(CharOffset + 1, CurrentIndex, LastSeenList),
            {NewAccAppeal, NewLastSeenList, CurrentIndex + 1}
        end,
        {0, InitialLastSeen, 0},
        CharList
    ),
    TotalAppeal.