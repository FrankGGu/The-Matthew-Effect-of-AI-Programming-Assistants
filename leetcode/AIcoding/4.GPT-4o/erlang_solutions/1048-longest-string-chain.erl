-module(solution).
-export([longest_str_chain/1]).

longest_str_chain(Words) ->
    SortedWords = lists:sort(fun(A, B) -> length(A) < length(B) end, Words),
    LongestChains = lists:foldl(fun(Word, Acc) -> 
        MaxChain = lists:max([1 + get_chain_length(Prev, Acc) || Prev <- lists:filter(fun(P) -> is_predecessor(P, Word) end, Acc)]),
        [{Word, MaxChain} | Acc]
    end, [], SortedWords),
    lists:max([Chain || {_, Chain} <- LongestChains]).

get_chain_length(Word, Chains) ->
    case lists:keyfind(Word, 1, Chains) of
        false -> 0;
        {Word, Length} -> Length
    end.

is_predecessor(Shorter, Longer) ->
    LengthDiff = length(Longer) - length(Shorter),
    LengthDiff =:= 1 andalso is_one_char_diff(Shorter, Longer).

is_one_char_diff(Shorter, Longer) ->
    lists:foldl(fun(C, {Diff, Prev}) ->
        case Diff of
            0 -> if C =:= hd(Prev) -> {0, tl(Prev)}; true -> {1, tl(Prev)} end;
            _ -> {Diff, tl(Prev)}
        end
    end, {0, tl(string:to_list(Longer))}, string:to_list(Shorter)) =:= {0, []}.