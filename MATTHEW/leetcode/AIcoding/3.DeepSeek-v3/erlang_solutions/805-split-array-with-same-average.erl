-module(solution).
-export([splitArraySameAverage/1]).

splitArraySameAverage(A) ->
    N = length(A),
    Total = lists:sum(A),
    Possible = false,
    Possible = check_possible(N, Total, Possible),
    if 
        not Possible -> false;
        true ->
            Memo = sets:new(),
            split_helper(A, 0, 0, 0, N, Total, Memo)
    end.

check_possible(N, Total, Possible) ->
    lists:foldl(fun(K, Acc) ->
        case (Total * K) rem N == 0 of
            true -> true;
            false -> Acc
        end
    end, Possible, lists:seq(1, N div 2)).

split_helper(_, K, Sum, Len, N, Total, _) when K > N div 2 ->
    false;
split_helper(A, K, Sum, Len, N, Total, Memo) ->
    case Len > 0 andalso (Total * Len) rem N == 0 andalso (Total * Len) div N == Sum of
        true -> true;
        false ->
            case sets:is_element({K, Sum, Len}, Memo) of
                true -> false;
                false ->
                    NewMemo = sets:add_element({K, Sum, Len}, Memo),
                    case K < length(A) of
                        true ->
                            case split_helper(A, K + 1, Sum + lists:nth(K + 1, A), Len + 1, N, Total, NewMemo) of
                                true -> true;
                                false -> split_helper(A, K + 1, Sum, Len, N, Total, NewMemo)
                            end;
                        false -> false
                    end
            end
    end.