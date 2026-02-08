-module(solution).
-export([minimum_time_to_revert_word_to_initial_state/1]).

minimum_time_to_revert_word_to_initial_state(W) ->
    N = length(W),
    KMPTable = build_kmp_table(W),
    Count = 0,
    Current = 0,
    lists:foldl(fun(_Char, Acc) ->
                        case Acc of
                            {_, _} -> Acc;
                            _ -> 
                                Next = get_next(KMPTable, Acc),
                                if Next == N -> {N, Acc + 1};
                                   true -> {Next, Acc}
                                end
                        end
                end, 0, W).

build_kmp_table(W) ->
    N = length(W),
    Table = array:new(N, {default, 0}),
    Len = 0,
    I = 1,
    build_kmp_table(W, Table, Len, I).

build_kmp_table(_, _, Len, I) when I >= length(W) -> Table;
build_kmp_table(W, Table, Len, I) ->
    case W--I of
        [H|_] ->
            case H == W--Len of
                true -> 
                    NewLen = Len + 1,
                    NewTable = array:set(I, NewLen, Table),
                    build_kmp_table(W, NewTable, NewLen, I+1);
                false ->
                    if Len > 0 -> build_kmp_table(W, Table, array:get(Len-1, Table), I);
                       true -> build_kmp_table(W, Table, 0, I+1)
                    end
            end
    end.

get_next(_, 0) -> 0;
get_next(Table, Index) -> array:get(Index, Table).