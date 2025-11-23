-module(cutting_cake).
-export([min_cost/2]).

min_cost(H, V) ->
    Height = lists:sort(H),
    Vertical = lists:sort(V),
    min_cost_helper(Height, Vertical).

min_cost_helper(Height, Vertical) ->
    H_len = length(Height),
    V_len = length(Vertical),
    DP = array:new([{size, {H_len + 1, V_len + 1}}, {default, 0}]),

    do_min_cost(Height, Vertical, 0, H_len, 0, V_len, DP).

do_min_cost(Height, Vertical, H_start, H_end, V_start, V_end, DP) ->
    case array:is_defined({H_start * (length(Vertical) + 1) + V_start}, DP) of
        true ->
            array:get({H_start * (length(Vertical) + 1) + V_start}, DP);
        false ->
            case H_start >= H_end and V_start >= V_end of
                true ->
                    0;
                false ->
                    H_cost = case H_start >= H_end of
                                 true ->
                                     infinity;
                                 false ->
                                     (lists:nth(H_end, [0 | Height]) - lists:nth(H_start + 1, [0 | Height])) + min_h_cost(Height, Vertical, H_start, H_end, V_start, V_end, DP)
                             end,
                    V_cost = case V_start >= V_end of
                                 true ->
                                     infinity;
                                 false ->
                                     (lists:nth(V_end, [0 | Vertical]) - lists:nth(V_start + 1, [0 | Vertical])) + min_v_cost(Height, Vertical, H_start, H_end, V_start, V_end, DP)
                             end,
                    Result = min(H_cost, V_cost),
                    array:set({H_start * (length(Vertical) + 1) + V_start}, Result, DP),
                    Result
            end
    end.

min_h_cost(Height, Vertical, H_start, H_end, V_start, V_end, DP) ->
    lists:foldl(
      fun(H_idx, Acc) ->
          Acc + do_min_cost(Height, Vertical, H_start, H_idx, V_start, V_end, DP) + do_min_cost(Height, Vertical, H_idx, H_end, V_start, V_end, DP)
      end,
      0,
      lists:seq(H_start + 1, H_end - 1)
    ).

min_v_cost(Height, Vertical, H_start, H_end, V_start, V_end, DP) ->
    lists:foldl(
      fun(V_idx, Acc) ->
          Acc + do_min_cost(Height, Vertical, H_start, H_end, V_start, V_idx, DP) + do_min_cost(Height, Vertical, H_start, H_end, V_idx, V_end, DP)
      end,
      0,
      lists:seq(V_start + 1, V_end - 1)
    ).

min(A, B) ->
    case A < B of
        true -> A;
        false -> B
    end.