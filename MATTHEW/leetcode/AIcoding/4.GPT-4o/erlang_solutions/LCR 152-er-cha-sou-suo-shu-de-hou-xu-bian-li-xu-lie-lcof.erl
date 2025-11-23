-module(solution).
-export([verify_postorder/1]).

verify_postorder(Postorder) ->
    verify_postorder_helper(Postorder, 0, length(Postorder) - 1).

verify_postorder_helper(Postorder, Start, End) when Start >= End ->
    true;
verify_postorder_helper(Postorder, Start, End) ->
    Root = lists:nth(End + 1, Postorder),
    SplitIndex = find_split_index(Postorder, Start, End, Root),
    (SplitIndex == -1 orelse SplitIndex == End) andalso
    verify_postorder_helper(Postorder, Start, SplitIndex - 1) andalso
    verify_postorder_helper(Postorder, SplitIndex, End - 1).

find_split_index(Postorder, Start, End, Root) ->
    lists:foldl(fun(X, Acc) -> 
        case Acc of 
            -1 -> 
                if 
                    X > Root -> 
                        lists:nth(Acc + 1, Postorder)
                else 
                    Acc 
                end;
            _ -> Acc
        end
    end, -1, lists:sublist(Postorder, Start + 1, End - Start)).