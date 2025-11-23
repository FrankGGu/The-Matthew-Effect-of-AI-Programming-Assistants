-module(solution).
-export([palindrome_pairs/1]).

palindrome_pairs(Words) ->
    N = length(Words),
    Map = maps:from_list([{lists:reverse(lists:nth(I, Words)), I} || I <- lists:seq(1, N)]),
    Result = lists:foldl(
        fun(I, Acc) ->
            Word = lists:nth(I, Words),
            M = length(Word),
            lists:foldl(
                fun(J, Acc1) ->
                    Prefix = string:substr(Word, 1, J),
                    Suffix = string:substr(Word, J + 1),
                    case is_palindrome(Prefix) of
                        true ->
                            case maps:get(Suffix, Map, -1) of
                                K when K =/= -1, K =/= I ->
                                    [[K - 1, I - 1] | Acc1];
                                _ ->
                                    Acc1
                            end;
                        false ->
                            Acc1
                    end
                end,
                lists:foldl(
                    fun(J, Acc2) ->
                        Prefix = string:substr(Word, 1, J),
                        Suffix = string:substr(Word, J + 1),
                        case is_palindrome(Suffix) of
                            true ->
                                case maps:get(Prefix, Map, -1) of
                                    K when K =/= -1, K =/= I ->
                                        [[I - 1, K - 1] | Acc2];
                                    _ ->
                                        Acc2
                                end;
                            false ->
                                Acc2
                        end
                    end,
                    Acc,
                    lists:seq(0, M)
                ),
                lists:seq(0, M)
            )
        end,
        [],
        lists:seq(1, N)
    ),
    lists:usort(Result).

is_palindrome(S) ->
    S =:= lists:reverse(S).