-module(solution).
-export([count_common_words/2]).

count_common_words(List1, List2) ->
    Map1 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(X) -> X + 1 end, 1, Acc) end, #{}, List1),
    Map2 = lists:foldl(fun(W, Acc) -> maps:update_with(W, fun(X) -> X + 1 end, 1, Acc) end, #{}, List2),
    CommonWords = maps:fold(fun(Key, Val1, Acc) ->
        case maps:is_key(Key, Map2) of
            true -> 
                case Val1 == 1 andalso maps:get(Key, Map2) == 1 of
                    true -> [Key | Acc];
                    false -> Acc
                end;
            false -> Acc
        end
    end, [], Map1),
    length(CommonWords).