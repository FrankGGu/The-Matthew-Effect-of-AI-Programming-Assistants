-module(solution).
-export([find_lexicographically_smallest/1]).

find_lexicographically_smallest(N) ->
    find_lexicographically_smallest(N, 0, []).

find_lexicographically_smallest(N, Pos, Acc) when Pos == N ->
    lists:reverse(Acc);
find_lexicographically_smallest(N, Pos, Acc) ->
    Start = if
        Pos == 0 -> $a;
        true -> lists:last(Acc) + 1
    end,
    lists:foldl(fun(Char, {Acc2, Found}) ->
        case Found of
            true -> {Acc2, true};
            false ->
                case is_valid(Acc2, Char) of
                    true -> {lists:append(Acc2, [Char]), true};
                    false -> {Acc2, false}
                end
        end
    end, {Acc, false}, lists:seq(Start, $z)).

is_valid([], _) -> true;
is_valid([Prev], C) -> Prev /= C;
is_valid([Prev1, Prev2], C) -> Prev1 /= C andalso Prev2 /= C.