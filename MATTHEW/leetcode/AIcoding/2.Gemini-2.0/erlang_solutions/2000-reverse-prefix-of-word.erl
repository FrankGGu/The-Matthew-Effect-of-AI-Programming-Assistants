-module(solution).
-export([reversePrefix/2]).

reversePrefix(Word, Ch) ->
    reversePrefix(Word, Ch, 1).

reversePrefix([H|T], Ch, Index) ->
    case H =:= Ch of
        true ->
            lists:reverse(lists:sublist([H|T], Index)) ++ lists:sublist([H|T], Index+1, length([H|T]) - Index);
        false ->
            case T of
                [] ->
                    Word;
                _ ->
                    reversePrefix(T, Ch, Index + 1)
            end
    end.