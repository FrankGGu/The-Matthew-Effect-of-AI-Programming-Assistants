-module(solution).
-export([num_ways/3]).

num_ways(Target, Words, Max) ->
    WordsList = lists:map(fun (Word) -> string:to_list(Word) end, Words),
    TargetList = string:to_list(Target),
    num_ways_helper(TargetList, WordsList, Max).

num_ways_helper([], _Words, _Max) -> 1;
num_ways_helper(_Target, [], _Max) -> 0;
num_ways_helper(Target, Words, Max) ->
    lists:foldl(fun (Word, Acc) -> 
        case can_form(Target, Word, Max) of
            true -> Acc + num_ways_helper(Target, Words, Max - 1);
            false -> Acc
        end
    end, 0, Words).

can_form([], _Word, _Max) -> true;
can_form(_Target, _Word, 0) -> false;
can_form([H | T], Word, Max) ->
    case lists:member(H, Word) of
        true -> can_form(T, Word, Max - 1);
        false -> false
    end.