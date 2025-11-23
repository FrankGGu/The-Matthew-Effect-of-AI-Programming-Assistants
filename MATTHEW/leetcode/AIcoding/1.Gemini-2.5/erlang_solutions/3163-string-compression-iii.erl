-module(solution).
-export([compress/1]).

-spec compress(Word :: unicode:unicode_binary()) -> unicode:unicode_binary().
compress(Word) ->
    compress_acc(Word, []).

compress_acc(<<>>, Acc) ->
    list_to_binary(lists:reverse(Acc)).

compress_acc(<<Char, Rest/binary>>, Acc) ->
    {Count, NewRest} = count_char(Char, Rest, 1),
    CountChar = integer_to_list(Count),
    compress_acc(NewRest, [Char, CountChar | Acc]).

count_char(TargetChar, <<TargetChar, Rest/binary>>, CurrentCount) when CurrentCount < 9 ->
    count_char(TargetChar, Rest, CurrentCount + 1);
count_char(_TargetChar, Rest, CurrentCount) ->
    {CurrentCount, Rest}.