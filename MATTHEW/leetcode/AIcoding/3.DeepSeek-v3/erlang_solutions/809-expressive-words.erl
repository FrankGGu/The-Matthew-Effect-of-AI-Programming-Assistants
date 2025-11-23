-module(expressive_words).
-export([expressiveWords/2]).

expressiveWords(S, Words) ->
    TargetGroups = group(S),
    lists:foldl(fun(Word, Acc) ->
        case is_expressive(Word, TargetGroups) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words).

group(S) ->
    group(S, []).

group([], Acc) ->
    lists:reverse(Acc);
group([H|T], []) ->
    group(T, [{H, 1}]);
group([H|T], [{Char, Count}|Rest]) when H =:= Char ->
    group(T, [{Char, Count + 1}|Rest]);
group([H|T], Acc) ->
    group(T, [{H, 1}|Acc]).

is_expressive(Word, TargetGroups) ->
    WordGroups = group(Word),
    case length(WordGroups) =:= length(TargetGroups) of
        false -> false;
        true ->
            lists:all(fun({{WChar, WCount}, {TChar, TCount}}) ->
                WChar =:= TChar andalso (WCount =:= TCount orelse (TCount >= 3 andalso WCount < TCount))
            end, lists:zip(WordGroups, TargetGroups))
    end.