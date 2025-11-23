-module(solution).
-export([max_product_of_the_length_of_two_palindromic_substrings/1]).

-include_lib("stdlib/include/array.hrl").

max_product_of_the_length_of_two_palindromic_substrings(S) ->
    N = length(S),
    case N < 2 of
        true -> 0;
        false ->
            S_arr = list_to_array(S),
            IsPal = build_is_pal_table(S_arr, N),
            Left = build_left_array(N, IsPal),
            Right = build_right_array(N, IsPal),
            calculate_max_product(N, Left, Right)
    end.

list_to_array(List) ->
    array:from_list(List).

build_is_pal_table(S_arr, N) ->
    EmptyRow = array:new({size, N}, [{default, false}]),
    IsPal = array:new({size, N}, [{default, EmptyRow}]),
    IsPal1 = build_is_pal_len1(IsPal, N, 0),
    IsPal2 = build_is_pal_len2(IsPal1, S_arr, N, 0),
    build_is_pal_len_recursive(IsPal2, S_arr, N, 2).

build_is_pal_len1(IsPal, N, I) when I < N ->
    Row = array:get(I, IsPal),
    NewRow = array:set(I, true, Row),
    NewIsPal = array:set(I, NewRow, IsPal),
    build_is_pal_len1(NewIsPal, N, I + 1);
build_is_pal_len1(IsPal, _, _) -> IsPal.

build_is_pal_len2(IsPal, S_arr, N, I) when I < N - 1 ->
    CharI = array:get(I, S_arr),
    CharI1 = array:get(I + 1, S_arr),
    NewIsPal =
        case CharI == CharI1 of
            true ->
                Row = array:get(I, IsPal),
                NewRow = array:set(I + 1, true, Row),
                array:set(I, NewRow, IsPal);
            false -> IsPal
        end,
    build_is_pal_len2(NewIsPal, S_arr, N, I + 1);
build_is_pal_len2(IsPal, _, _, _) -> IsPal.

build_is_pal_len_recursive(IsPal, S_arr, N, LenIdx) when LenIdx < N ->
    CurrentLen = LenIdx + 1,
    NewIsPal = build_is_pal_for_current_len(IsPal, S_arr, N, CurrentLen, 0),
    build_is_pal_len_recursive(NewIsPal, S_arr, N, LenIdx + 1);
build_is_pal_len_recursive(IsPal, _, _, _) -> IsPal.

build_is_pal_for_current_len(IsPal, S_arr, N, CurrentLen, I) when I <= N - CurrentLen ->
    J = I + CurrentLen - 1,
    CharI = array:get(I, S_arr),
    CharJ = array:get(J, S_arr),

    IsPal_I_plus_1_J_minus_1 = get_is_pal(IsPal, I + 1, J - 1),

    IsCurrentPal = (CharI == CharJ) andalso IsPal_I_plus_1_J_minus_1,

    NewIsPal =
        case IsCurrentPal of
            true ->
                Row = array:get(I, IsPal),
                NewRow = array:set(J, true, Row),
                array:set(I, NewRow, IsPal);
            false -> IsPal
        end,
    build_is_pal_for_current_len(NewIsPal, S_arr, N, CurrentLen, I + 1);
build_is_pal_for_current_len(IsPal, _, _, _, _) -> IsPal.

get_is_pal(IsPal, I, J) when I > J -> true;
get_is_pal(IsPal, I, J) ->
    Row = array:get(I, IsPal),
    array:get(J, Row).

build_left_array(N, IsPal) ->
    Left = array:new({size, N}, [{default, 0}]),
    build_left_array_recursive(Left, N, IsPal, 0).

build_left_array_recursive(Left, N, IsPal, K) when K < N ->
    CurrentMax = case K > 0 of
                    true -> array:get(K - 1, Left);
                    false -> 0
                 end,

    MaxLenEndingAtK = find_max_len_palindrome_ending_at_K(IsPal, K, 0, CurrentMax),

    NewLeft = array:set(K, MaxLenEndingAtK, Left),
    build_left_array_recursive(NewLeft, N, IsPal, K + 1);
build_left_array_recursive(Left, _, _, _) -> Left.

find_max_len_palindrome_ending_at_K(IsPal, K, J, CurrentMax) when J <= K ->
    IsCurrentPal = get_is_pal(IsPal, J, K),
    NewMax = case IsCurrentPal of
                true -> max(CurrentMax, K - J + 1);
                false -> CurrentMax
             end,
    find_max_len_palindrome_ending_at_K(IsPal, K, J + 1, NewMax);
find_max_len_palindrome_ending_at_K(_, _, _, CurrentMax) -> CurrentMax.

build_right_array(N, IsPal) ->
    Right = array:new({size, N}, [{default, 0}]),
    build_right_array_recursive(Right, N, IsPal, N - 1).

build_right_array_recursive(Right, N, IsPal, K) when K >= 0 ->
    CurrentMax = case K < N - 1 of
                    true -> array:get(K + 1, Right);
                    false -> 0
                 end,

    MaxLenStartingAtK = find_max_len_palindrome_starting_at_K(IsPal, K, N - 1, CurrentMax),

    NewRight = array:set(K, MaxLenStartingAtK, Right),
    build_right_array_recursive(NewRight, N, IsPal, K - 1);
build_right_array_recursive(Right, _, _, _, _) -> Right.

find_max_len_palindrome_starting_at_K(IsPal, K, J, CurrentMax) when J >= K ->
    IsCurrentPal = get_is_pal(IsPal, K, J),
    NewMax = case IsCurrentPal of
                true -> max(CurrentMax, J - K + 1);
                false -> CurrentMax
             end,
    find_max_len_palindrome_starting_at_K(IsPal, K, J - 1, NewMax);
find_max_len_palindrome_starting_at_K(_, _, _, CurrentMax) -> CurrentMax.

calculate_max_product(N, Left, Right) ->
    calculate_max_product_recursive(N, Left, Right, 0, 0).

calculate_max_product_recursive(N, Left, Right, K, MaxProd) when K < N - 1 ->
    LeftVal = array:get(K, Left),
    RightVal = array:get(K + 1, Right),

    CurrentProd = LeftVal * RightVal,
    NewMaxProd = max(MaxProd, CurrentProd),
    calculate_max_product_recursive(N, Left, Right, K + 1, NewMaxProd);
calculate_max_product_recursive(_, _, _, _, MaxProd) -> MaxProd.