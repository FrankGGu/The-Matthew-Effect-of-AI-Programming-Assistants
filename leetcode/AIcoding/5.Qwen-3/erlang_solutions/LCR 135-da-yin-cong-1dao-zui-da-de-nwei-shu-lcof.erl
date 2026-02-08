-module(CountAndSay).
-export([count_and_say/1]).

count_and_say(1) -> "1";
count_and_say(N) ->
    Prev = count_and_say(N-1),
    say(Prev, 0, $0, []).

say([], _, _, Acc) -> lists:reverse(Acc);
say([C | Rest], Count, C, Acc) ->
    say(Rest, Count + 1, C, Acc);
say([C | Rest], Count, _, Acc) ->
    say(Rest, 1, C, [C | [integer_to_list(Count) | Acc]]).

say([], _, _, Acc) -> lists:reverse(Acc).