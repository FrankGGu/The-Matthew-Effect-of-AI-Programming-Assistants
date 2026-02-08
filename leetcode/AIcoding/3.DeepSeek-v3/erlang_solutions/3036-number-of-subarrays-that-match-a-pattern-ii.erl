-spec num_of_subarrays(Nums :: [integer()], Pattern :: [integer()]) -> integer().
num_of_subarrays(Nums, Pattern) ->
    N = length(Nums),
    M = length(Pattern),
    if
        N < M + 1 -> 0;
        true ->
            P = preprocess_pattern(Pattern),
            Text = create_comparison_list(Nums),
            KMPSearch(Text, Pattern, P)
    end.

preprocess_pattern(Pattern) ->
    M = length(Pattern),
    P = array:new(M, {default, 0}),
    preprocess_pattern(Pattern, P, 2, 0).

preprocess_pattern(Pattern, P, K, Len) ->
    M = length(Pattern),
    if
        K > M -> P;
        true ->
            case Len > 0 andalso compare(Pattern, K - 1, Len) of
                false ->
                    if
                        Len == 0 ->
                            preprocess_pattern(Pattern, array:set(K, 0, P), K + 1, 0);
                        true ->
                            Len1 = array:get(Len, P),
                            preprocess_pattern(Pattern, P, K, Len1)
                    end;
                true ->
                    Len1 = Len + 1,
                    P1 = array:set(K, Len1, P),
                    preprocess_pattern(Pattern, P1, K + 1, Len1)
            end
    end.

compare(Pattern, I, Len) ->
    case lists:nth(I, Pattern) == lists:nth(Len, Pattern) of
        true -> true;
        false -> false
    end.

create_comparison_list(Nums) ->
    create_comparison_list(Nums, [], 1).

create_comparison_list([_], Acc, _) -> lists:reverse(Acc);
create_comparison_list([A, B | Rest], Acc, I) ->
    Cmp = if
              A < B -> -1;
              A == B -> 0;
              true -> 1
          end,
    create_comparison_list([B | Rest], [Cmp | Acc], I + 1).

KMPSearch(Text, Pattern, P) ->
    M = length(Pattern),
    N = length(Text),
    KMPSearch(Text, Pattern, P, 0, 0, 0, M, N).

KMPSearch(Text, Pattern, P, I, J, Count, M, N) ->
    if
        I < N ->
            case J > 0 andalso (J >= M orelse compare_pattern(Text, I, Pattern, J)) of
                false ->
                    if
                        J == M -> 
                            KMPSearch(Text, Pattern, P, I, array:get(J, P), Count + 1, M, N);
                        true ->
                            case compare_pattern(Text, I, Pattern, J + 1) of
                                true ->
                                    KMPSearch(Text, Pattern, P, I + 1, J + 1, Count, M, N);
                                false ->
                                    if
                                        J == 0 ->
                                            KMPSearch(Text, Pattern, P, I + 1, 0, Count, M, N);
                                        true ->
                                            NewJ = array:get(J, P),
                                            KMPSearch(Text, Pattern, P, I, NewJ, Count, M, N)
                                    end
                            end
                    end;
                true ->
                    NewJ = array:get(J, P),
                    KMPSearch(Text, Pattern, P, I, NewJ, Count, M, N)
            end;
        true ->
            if
                J == M -> Count + 1;
                true -> Count
            end
    end.

compare_pattern(Text, I, Pattern, J) ->
    case lists:nth(I + 1, Text) == lists:nth(J, Pattern) of
        true -> true;
        false -> false
    end.