-spec find_the_string(Lcp :: [[integer()]]) -> unicode:unicode_binary().
find_the_string(Lcp) ->
    N = length(Lcp),
    case N =:= 0 orelse length(hd(Lcp)) =/= N of
        true -> <<>>;
        false ->
            Word = array:new(N, {default, $a}),
            case build_word(Word, Lcp, 0, N) of
                {ok, ValidWord} ->
                    case verify_lcp(ValidWord, Lcp) of
                        true -> list_to_binary(ValidWord);
                        false -> <<>>
                    end;
                error -> <<>>
            end
    end.

build_word(Word, Lcp, I, N) when I >= N -> {ok, array:to_list(Word)};
build_word(Word, Lcp, I, N) ->
    case array:get(I, Word) of
        $a ->
            NewWord = array:set(I, $a, Word),
            build_word_loop(NewWord, Lcp, I, I, N);
        _ ->
            build_word(Word, Lcp, I + 1, N)
    end.

build_word_loop(Word, Lcp, I, J, N) when J >= N -> build_word(Word, Lcp, I + 1, N);
build_word_loop(Word, Lcp, I, J, N) ->
    case I + J >= N of
        true -> build_word_loop(Word, Lcp, I, J + 1, N);
        false ->
            case Lcp !! I !! J of
                0 ->
                    case array:get(I + J, Word) of
                        $a -> build_word_loop(array:set(I + J, $b, Word), Lcp, I, J + 1, N);
                        _ -> build_word_loop(Word, Lcp, I, J + 1, N)
                    end;
                Len when Len > 0 ->
                    case I + Len < N andalso J + Len < N of
                        true ->
                            case array:get(I, Word) =:= array:get(J, Word) of
                                true -> build_word_loop(Word, Lcp, I, J + 1, N);
                                false -> error
                            end;
                        false -> error
                    end;
                _ -> error
            end
    end.

verify_lcp(Word, Lcp) ->
    N = length(Word),
    ComputedLCP = compute_lcp(Word),
    lists:all(fun(I) ->
        lists:all(fun(J) ->
            (Lcp !! I !! J) =:= (ComputedLCP !! I !! J)
        end, lists:seq(0, N - 1))
    end, lists:seq(0, N - 1)).

compute_lcp(Word) ->
    N = length(Word),
    LCP = [[0 || _ <- lists:seq(1, N)] || _ <- lists:seq(1, N)],
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case I =:= J of
                true -> set_lcp(Acc1, I, J, N - I);
                false ->
                    case I > J of
                        true -> Acc1;
                        false ->
                            case Word !! I =:= Word !! J of
                                true -> 
                                    Len = if I + 1 < N andalso J + 1 < N -> (Acc1 !! (I + 1) !! (J + 1)) + 1;
                                             true -> 1
                                          end,
                                    set_lcp(set_lcp(Acc1, I, J, Len), J, I, Len);
                                false -> set_lcp(set_lcp(Acc1, I, J, 0), J, I, 0)
                            end
                    end
            end
        end, Acc, lists:seq(0, N - 1))
    end, LCP, lists:seq(0, N - 1)).

set_lcp(LCP, I, J, Val) ->
    Row = LCP !! I,
    NewRow = setelement(J + 1, Row, Val),
    setelement(I + 1, LCP, NewRow).

!!(List, Index) -> lists:nth(Index + 1, List).