-module(solution).
-export([max_number_of_non_overlapping_palindrome_substrings/2]).

fill_is_pal(Arr, N) ->
    IsPal0 = array:new(N, fun(_) -> array:new(N, false) end),

    IsPal1 = lists:foldl(fun(J, CurrentIsPal) ->
        RowJ = array:get(J, CurrentIsPal),
        NewRowJ = array:set(J, true, RowJ),
        array:set(J, NewRowJ, CurrentIsPal)
    end, IsPal0, lists:seq(0, N-1)),

    IsPal2 = lists:foldl(fun(J, CurrentIsPal) ->
        I = J + 1,
        case array:get(J, Arr) == array:get(I, Arr) of
            true ->
                RowJ = array:get(J, CurrentIsPal),
                NewRowJ = array:set(I, true, RowJ),
                array:set(J, NewRowJ, CurrentIsPal);
            false ->
                CurrentIsPal
        end
    end, IsPal1, lists:seq(0, N-2)),

    lists:foldl(fun(Len, CurrentIsPal) ->
        lists:foldl(fun(J, InnerIsPal) ->
            I = J + Len - 1,
            case {array:get(J, Arr) == array:get(I, Arr), array:get(I-1, array:get(J+1, InnerIsPal))} of
                {true, true} ->
                    RowJ = array:get(J, InnerIsPal),
                    NewRowJ = array:set(I, true, RowJ),
                    array:set(J, NewRowJ, InnerIsPal);
                _ ->
                    InnerIsPal
            end
        end, CurrentIsPal, lists:seq(0, N - Len))
    end, IsPal2, lists:seq(3, N)).

max_number_of_non_overlapping_palindrome_substrings(S, K) ->
    Arr = array:from_list(S),
    N = array:size(Arr),

    if N < K -> 0;
       true ->
            IsPal = fill_is_pal(Arr, N),

            DP0 = array:new(N+1, 0),

            FinalDP = lists:foldl(fun(I, CurrentDP) ->
                Val1 = array:get(I-1, CurrentDP),

                MaxVal2 = lists:foldl(fun(J, AccMax) ->
                    Len = I - J,
                    case Len >= K andalso array:get(I-1, array:get(J, IsPal)) of
                        true ->
                            max(AccMax, 1 + array:get(J, CurrentDP));
                        false ->
                            AccMax
                    end
                end, 0, lists:seq(0, I-1)),

                array:set(I, max(Val1, MaxVal2), CurrentDP)
            end, DP0, lists:seq(1, N)),

            array:get(N, FinalDP)
    end.