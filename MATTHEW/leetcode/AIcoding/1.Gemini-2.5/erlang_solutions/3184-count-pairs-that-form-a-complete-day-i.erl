-module(solution).
-export([countPairsThatFormACompleteDay/1]).

countPairsThatFormACompleteDay(Times) ->
    InitialRemainders = array:new({23, 0}),
    {Count, _FinalRemainders} = lists:foldl(
        fun(Time, {AccCount, RemaindersArr}) ->
            Rem = Time rem 24,
            Complement = (24 - Rem) rem 24,

            ComplementCount = array:get(Complement, RemaindersArr),

            NewAccCount = AccCount + ComplementCount,

            CurrentRemCount = array:get(Rem, RemaindersArr),
            NewRemaindersArr = array:set(Rem, CurrentRemCount + 1, RemaindersArr),

            {NewAccCount, NewRemaindersArr}
        end,
        {0, InitialRemainders},
        Times
    ),
    Count.