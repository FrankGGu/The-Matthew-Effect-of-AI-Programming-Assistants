-module(solution).
-export([min_window/2]).

build_char_counts(Str) ->
    lists:foldl(fun(Char, Acc) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                end, #{}, Str).

min_window(S, T) ->
    S_len = length(S),
    T_len = length(T),

    if
        T_len == 0 ->
            "";
        S_len == 0 ->
            "";
        S_len < T_len ->
            ""
    else
        T_counts = build_char_counts(T),
        Required_formed = maps:size(T_counts),

        S_bin = list_to_binary(S),

        % slide(S_bin, T_counts, Window_counts, Left_ptr, Right_ptr, Formed, Required_formed, Min_len, Min_start_idx, S_len)
        Min_res = slide(S_bin, T_counts, #{}, 0, 0, 0, Required_formed, S_len + 1, -1, S_len),

        case Min_res of
            {_, _, _, _, -1, _} ->
                "";
            {Min_len_val, Min_start_idx_val, _, _, _, _} ->
                binary_to_list(binary:part(S_bin, Min_start_idx_val, Min_len_val))
        end
    end.

slide(S_bin, T_counts, Window_counts, Left_ptr, Right_ptr, Formed, Required_formed, Min_len, Min_start_idx, S_len) when Right_ptr < S_len ->
    Char_r = binary:at(S_bin, Right_ptr),

    New_window_counts = maps:update_with(Char_r, fun(Count) -> Count + 1 end, 1, Window_counts),

    New_formed = 
        case maps:find(Char_r, T_counts) of
            {ok, T_char_count} when maps:get(Char_r, New_window_counts) == T_char_count ->
                Formed + 1;
            _ ->
                Formed
        end,

    % Try to shrink the window from the left
    {Updated_min_len, Updated_min_start_idx, Final_window_counts, Final_formed, Final_left_ptr} =
        shrink_window(S_bin, T_counts, New_window_counts, Left_ptr, Right_ptr, New_formed, Required_formed, Min_len, Min_start_idx, S_len),

    % Continue expanding the window
    slide(S_bin, T_counts, Final_window_counts, Final_left_ptr, Right_ptr + 1, Final_formed, Required_formed, Updated_min_len, Updated_min_start_idx, S_len);

slide(_S_bin, _T_counts, _Window_counts, _Left_ptr, _Right_ptr, _Formed, _Required_formed, Min_len, Min_start_idx, _S_len) ->
    {Min_len, Min_start_idx, _Window_counts, _Formed, _Left_ptr, _Right_ptr}.

shrink_window(S_bin, T_counts, Window_counts, Left_ptr, Right_ptr, Formed, Required_formed, Min_len, Min_start_idx, S_len) ->
    if
        Formed == Required_formed ->
            Current_len = Right_ptr - Left_ptr + 1,
            {New_min_len, New_min_start_idx} = 
                if Current_len < Min_len ->
                    {Current_len, Left_ptr};
                true ->
                    {Min_len, Min_start_idx}
                end,

            Char_l = binary:at(S_bin, Left_ptr),
            Updated_window_counts = maps:update_with(Char_l, fun(Count) -> Count - 1 end, 0, Window_counts),

            Updated_formed = 
                case maps:find(Char_l, T_counts) of
                    {ok, T_char_count} when maps:get(Char_l, Updated_window_counts) < T_char_count ->
                        Formed - 1;
                    _ ->
                        Formed
                end,

            % Recurse to shrink further
            shrink_window(S_bin, T_counts, Updated_window_counts, Left_ptr + 1, Right_ptr, Updated_formed, Required_formed, New_min_len, New_min_start_idx, S_len);
        true -> % Formed < Required_formed, cannot shrink further
            {Min_len, Min_start_idx, Window_counts, Formed, Left_ptr}
    end.