-module(buddy_strings).
-export([buddyStrings/2]).

buddyStrings(A, B) ->
    case length(A) == length(B) of
        false -> false;
        true ->
            case A == B of
                true -> lists:member(true, [lists:member(X, A) || X <- A]) andalso length(A) >= 2;
                false ->
                    Diff = lists:foldl(fun(I, Acc) ->
                                           case lists:nth(I, A) /= lists:nth(I, B) of
                                               true -> [I | Acc];
                                               false -> Acc
                                           end
                                       end, [], lists:seq(1, length(A))),
                    length(Diff) == 2 andalso lists:nth(hd(Diff), A) == lists:nth(hd(Diff), B) andalso lists:nth(lists:last(Diff), A) == lists:nth(lists:last(Diff), B)
            end
    end.