-module(number_of_different_integers_in_a_string).
-export([numDifferentIntegers/1]).

numDifferentIntegers(Word) ->
    numDifferentIntegers(Word, []).

numDifferentIntegers([], Acc) ->
    length(lists:usort(Acc));
numDifferentIntegers([H|T], Acc) when H >= $0, H =< $9 ->
    {NumStr, Rest} = getNumber([H|T], []),
    Number = list_to_integer(lists:dropwhile(fun(C) -> C == $0 end, NumStr)),
    numDifferentIntegers(Rest, [Number|Acc]);
numDifferentIntegers([_|T], Acc) ->
    numDifferentIntegers(T, Acc).

getNumber(Str, Acc) ->
    getNumber(Str, Acc, []).

getNumber([], Acc, Acc2) ->
    {lists:reverse(Acc2), []};
getNumber([H|T], Acc, Acc2) when H >= $0, H =< $9 ->
    getNumber(T, Acc, [H|Acc2]);
getNumber(Str, Acc, Acc2) ->
    {lists:reverse(Acc2), Str}.