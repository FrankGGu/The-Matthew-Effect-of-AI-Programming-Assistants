-module(circular_sentence).
-export([is_circular/1]).

is_circular(S) ->
    Words = string:split(S, " "),
    is_circular(Words, hd(Words), 0).

is_circular([], _, _) -> true;
is_circular([W | Rest], Prev, Index) ->
    case Index of
        0 -> is_circular(Rest, W, 1);
        _ ->
            LastChar = lists:last(W),
            FirstChar = hd(Prev),
            if
                LastChar == FirstChar -> is_circular(Rest, W, Index + 1);
                true -> false
            end
    end.