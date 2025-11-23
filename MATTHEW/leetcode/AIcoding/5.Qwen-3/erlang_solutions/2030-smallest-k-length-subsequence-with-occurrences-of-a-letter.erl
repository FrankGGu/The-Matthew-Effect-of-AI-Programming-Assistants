-module(solution).
-export([smallest_k_length_subsequence/2]).

smallest_k_length_subsequence(S, K) ->
    N = length(S),
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
    MinChar = find_min_char(Count),
    List = string:to_list(S),
    {Selected, _} = select(List, K, 0, [], Count, MinChar),
    list_to_binary(Selected).

find_min_char(Count) ->
    lists:foldl(fun({Char, _}, MinChar) ->
        if
            Char < MinChar -> Char;
            true -> MinChar
        end
    end, $z, maps:to_list(Count)).

select([], _, _, Selected, _, _) ->
    {lists:reverse(Selected), 0};
select([H | T], K, Index, Selected, Count, MinChar) ->
    if
        K == 0 ->
            {lists:reverse(Selected), Index};
        true ->
            Remaining = length(T),
            IfPossible = (maps:get(H, Count) > 0) andalso (K - 1 + (maps:get(H, Count) - 1) >= Remaining),
            if
                H == MinChar andalso IfPossible ->
                    NewCount = maps:update(H, maps:get(H, Count) - 1, Count),
                    select(T, K - 1, Index + 1, [H | Selected], NewCount, MinChar);
                H < MinChar andalso IfPossible ->
                    NewCount = maps:update(H, maps:get(H, Count) - 1, Count),
                    select(T, K - 1, Index + 1, [H | Selected], NewCount, MinChar);
                true ->
                    select(T, K, Index + 1, Selected, Count, MinChar)
            end
    end.