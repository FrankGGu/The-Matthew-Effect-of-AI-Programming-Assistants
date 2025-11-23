-spec find_the_difference(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> char().
find_the_difference(S, T) ->
    SList = unicode:characters_to_list(S),
    TList = unicode:characters_to_list(T),
    SumS = lists:sum(SList),
    SumT = lists:sum(TList),
    SumT - SumS.