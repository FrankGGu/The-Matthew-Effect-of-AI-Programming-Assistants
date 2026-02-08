-module(solution).
-export([buddy_strings/2]).

buddy_strings(A, B) when length(A) == length(B) ->
    case A == B of
        true -> 
            lists:uniq(lists:sort(A)) /= lists:sort(A);
        false ->
            Diff = lists:filter(fun(X) -> lists:nth(X, A) /= lists:nth(X, B) end, lists:seq(1, length(A))),
            case length(Diff) of
                2 -> 
                    {X1, X2} = {lists:nth(hd(Diff), A), lists:nth(hd(tl(Diff)), A)},
                    {Y1, Y2} = {lists:nth(hd(Diff), B), lists:nth(hd(tl(Diff)), B)},
                    X1 == Y2 andalso X2 == Y1;
                _ -> false
            end
    end.