-module(solution).
-export([can_transform/2]).

-spec can_transform(StartString :: unicode:unicode_binary(), EndString :: unicode:unicode_binary()) -> boolean().
can_transform(StartString, EndString) ->
    Len = byte_size(StartString),
    if
        Len =/= byte_size(EndString) ->
            false;
        true ->
            can_transform_loop(StartString, EndString, 0, 0, Len)
    end.

can_transform_loop(StartString, EndString, I, J, Len) ->
    I_next_non_x = find_next_non_x(StartString, I, Len),
    J_next_non_x = find_next_non_x(EndString, J, Len),

    if
        I_next_non_x == Len andalso J_next_non_x == Len ->
            true;
        I_next_non_x == Len orelse J_next_non_x == Len ->
            false;
        true ->
            StartChar = binary:at(StartString, I_next_non_x),
            EndChar = binary:at(EndString, J_next_non_x),

            if
                StartChar =/= EndChar ->
                    false;
                StartChar == $L andalso J_next_non_x > I_next_non_x ->
                    false;
                StartChar == $R andalso J_next_non_x < I_next_non_x ->
                    false;
                true ->
                    can_transform_loop(StartString, EndString, I_next_non_x + 1, J_next_non_x + 1, Len)
            end
    end.

find_next_non_x(Str, K, Len) ->
    if
        K >= Len ->
            Len;
        binary:at(Str, K) == $X ->
            find_next_non_x(Str, K + 1, Len);
        true ->
            K
    end.