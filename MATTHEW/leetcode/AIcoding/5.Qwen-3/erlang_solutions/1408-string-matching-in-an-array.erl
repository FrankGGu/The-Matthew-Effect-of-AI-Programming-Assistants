-module(string_matching_in_an_array).
-export([stringMatching/1]).

stringMatching(Items) ->
    lists:foldl(fun(Item, Acc) ->
        case lists:any(fun(Other) -> Item =/= Other andalso string:contains(Other, Item) end, Items) of
            true -> Acc;
            false -> [Item | Acc]
        end
    end, [], Items).

string:contains(A, B) ->
    case string:rstr(A, B) of
        0 -> false;
        _ -> true
    end.