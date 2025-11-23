-module(solution).
-export([count_matches/3]).

-spec count_matches(Items :: [[unicode:unicode_binary()]], RuleKey :: unicode:unicode_binary(), RuleValue :: unicode:unicode_binary()) -> integer().
count_matches(Items, RuleKey, RuleValue) ->
    Index = case RuleKey of
        <<"type">> -> 0;
        <<"color">> -> 1;
        <<"name">> -> 2
    end,

    lists:foldl(fun(Item, Acc) ->
        ItemElement = lists:nth(Index + 1, Item),
        if ItemElement == RuleValue -> Acc + 1;
           true -> Acc
        end
    end, 0, Items).