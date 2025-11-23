-module(remove_one_element).
-export([can_be_increasing/1]).

can_be_increasing(Nums) ->
    can_be_increasing(Nums, 0, -infinity, false).

can_be_increasing([], _Index, _Prev, _Skipped) ->
    true;
can_be_increasing([H | T], Index, Prev, Skipped) ->
    if
        H > Prev ->
            can_be_increasing(T, Index + 1, H, Skipped);
        true ->
            case Skipped of
                true ->
                    false;
                false ->
                    case Index of
                        0 ->
                            can_be_increasing(T, Index + 1, H, true);
                        _ ->
                            if
                                Index == 1 ->
                                    can_be_increasing(T, Index + 1, H, true);
                                true ->
                                    if
                                        lists:nth(Index - 1, Nums) < H ->
                                            can_be_increasing(T, Index + 1, H, true);
                                        true ->
                                            false
                                    end
                            end
                    end
            end
    end.