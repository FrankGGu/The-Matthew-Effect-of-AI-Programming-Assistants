-module(solution).
-export([k_mirror_sum/2]).

is_palindrome_in_base(N, Base) ->
    Digits = to_base(N, Base),
    Digits == lists:reverse(Digits).

to_base(0, _Base) -> [0];
to_base(N, Base) when N > 0 ->
    to_base_acc(N, Base, []).

to_base_acc(0, _Base, Acc) -> Acc;
to_base_acc(N, Base, Acc) ->
    to_base_acc(N div Base, Base, [N rem Base | Acc]).

make_palindrome_odd(N) ->
    S = integer_to_list(N),
    list_to_integer(S ++ lists:reverse(lists:droplast(S))).

make_palindrome_even(N) ->
    S = integer_to_list(N),
    list_to_integer(S ++ lists:reverse(S)).

k_mirror_sum(N, K) ->
    MaxHalf = 4000,
    Palindromes = lists:sort(lists:usort(
        [make_palindrome_odd(I) || I <- lists:seq(1, MaxHalf)] ++
        [make_palindrome_even(I) || I <- lists:seq(1, MaxHalf)]
    )),

    FoundKMirrors = find_k_mirror_numbers(Palindromes, K, N, []),
    lists:sum(FoundKMirrors).

find_k_mirror_numbers([H|T], K, Count, Acc) when Count > 0 ->
    if
        is_palindrome_in_base(H, K) ->
            find_k_mirror_numbers(T, K, Count - 1, [H | Acc]);
        true ->
            find_k_mirror_numbers(T, K, Count, Acc)
    end;
find_k_mirror_numbers(_Palindromes, _K, _Count, Acc) ->
    lists:reverse(Acc).