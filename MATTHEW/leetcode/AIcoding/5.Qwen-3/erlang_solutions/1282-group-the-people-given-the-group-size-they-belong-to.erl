-module(group_the_people).
-export([groupThePeople/1]).

groupThePeople(Groups) ->
    groupThePeople(Groups, #{}).

groupThePeople([], Acc) ->
    lists:foldl(fun({_K, V}, Acc2) -> Acc2 ++ [V] end, [], maps:to_list(Acc));
groupThePeople([{Id, Size} | Rest], Acc) ->
    case maps:find(Size, Acc) of
        {ok, List} ->
            NewList = [Id | List],
            groupThePeople(Rest, maps:put(Size, NewList, Acc));
        error ->
            groupThePeople(Rest, maps:put(Size, [Id], Acc))
    end.