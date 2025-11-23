-module(min_window).
-export([min_window/2]).

min_window(S, T) ->
    min_window(string_to_list(S), string_to_list(T)).

min_window(SList, TList) ->
    TLen = length(TList),
    SLen = length(SList),
    if TLen > SLen ->
        ""
    else
        Need = lists:foldl(fun(C, Acc) ->
                                  maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                              end, #{}, TList),
        {BestStart, BestEnd} = min_window_helper(SList, Need, TLen, 0, -1, SLen - 1, #{}),
        if BestStart =:= -1 ->
            ""
        else
            list_to_string(lists:sublist(SList, BestStart + 1, BestEnd - BestStart + 1))
        end
    end.

min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, Have) ->
    min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, Have, 0, 0).

min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, Have, Left, Right) ->
    SLen = length(SList),
    if Right >= SLen ->
        {BestStart, BestEnd}
    else
        CharRight = lists:nth(Right, SList),
        NewHave = maps:update_with(CharRight, fun(V) -> V + 1 end, 1, Have),
        Valid = case maps:find(CharRight, Need) of
                    error -> 0;
                    {ok, NeedVal} ->
                        case maps:find(CharRight, NewHave) of
                            error -> 0;
                            {ok, HaveVal} ->
                                if HaveVal =< NeedVal then 1 else 0 end
                        end
                end,

        ValidCount = get_valid_count(NewHave, Need),

        case ValidCount >= TLen of
            true ->
                CharLeft = lists:nth(Left, SList),
                case maps:find(CharLeft, Need) of
                    error ->
                        NewLeft = Left + 1,
                        min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, NewHave, NewLeft, Right);
                    {ok, NeedVal} ->
                        case maps:find(CharLeft, NewHave) of
                            error ->
                                NewLeft = Left + 1,
                                min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, NewHave, NewLeft, Right);
                            {ok, HaveVal} ->
                                if HaveVal > NeedVal then
                                    NewHave2 = maps:update_with(CharLeft, fun(V) -> V - 1 end, 0, NewHave),
                                    NewLeft = Left + 1,
                                    min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, NewHave2, NewLeft, Right)
                                else
                                    if BestStart =:= -1 orelse (Right - Left) < (BestEnd - BestStart) then
                                        min_window_helper(SList, Need, TLen, Start, Left, Right, NewHave, Left, Right + 1)
                                    else
                                        min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, NewHave, Left, Right + 1)
                                    end
                                end
                        end
                end;
            false ->
                min_window_helper(SList, Need, TLen, Start, BestStart, BestEnd, NewHave, Left, Right + 1)
        end.

get_valid_count(Have, Need) ->
    maps:fold(fun(K, NeedVal, Acc) ->
                      case maps:find(K, Have) of
                          error -> Acc;
                          {ok, HaveVal} ->
                              if HaveVal >= NeedVal then
                                  Acc + 1
                              else
                                  Acc
                              end
                      end
              end, 0, Need).