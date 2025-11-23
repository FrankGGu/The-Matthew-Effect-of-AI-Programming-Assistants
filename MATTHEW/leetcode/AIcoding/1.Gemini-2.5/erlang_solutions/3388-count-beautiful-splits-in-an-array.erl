-module(solution).
-export([beautifulSplits/2]).

is_prime(2) -> true;
is_prime(3) -> true;
is_prime(5) -> true;
is_prime(7) -> true;
is_prime(11) -> true;
is_prime(13) -> true;
is_prime(17) -> true;
is_prime(19) -> true;
is_prime(23) -> true;
is_prime(29) -> true;
is_prime(_) -> false.

popcount(0) -> 0;
popcount(N) when N > 0 ->
    popcount_acc(N, 0).

popcount_acc(0, Acc) -> Acc;
popcount_acc(N, Acc) ->
    popcount_acc(N bsr 1, Acc + (N band 1)).

make_prefix_xor(Nums) ->
    make_prefix_xor_acc(Nums, 0, [0]).

make_prefix_xor_acc([], _CurrentXOR, Acc) ->
    list_to_tuple(lists:reverse(Acc));
make_prefix_xor_acc([H|T], CurrentXOR, Acc) ->
    NewXOR = CurrentXOR bxor H,
    make_prefix_xor_acc(T, NewXOR, [NewXOR|Acc]).

beautifulSplits(Nums, K) ->
    N = length(Nums),
    if N < 2 -> % A split requires at least two non-empty parts
        0;
    true ->
        if not is_prime(K) -> % K must be a prime number for any split to be beautiful
            0;
        true ->
            PrefixXOR_tuple = make_prefix_xor(Nums),
            TotalXOR = element(N + 1, PrefixXOR_tuple), % XOR sum of all elements
            count_splits(1, N, K, PrefixXOR_tuple, TotalXOR, 0)
        end
    end.

count_splits(I, N, K, PrefixXOR_tuple, TotalXOR, Count) when I < N ->
    % LeftXOR is the XOR sum of nums[0...I-1], which is element(I+1, PrefixXOR_tuple)
    LeftXOR = element(I + 1, PrefixXOR_tuple),
    % RightXOR is the XOR sum of nums[I...N-1], which is TotalXOR ^ LeftXOR
    RightXOR = TotalXOR bxor LeftXOR,

    LeftPopcount = popcount(LeftXOR),
    RightPopcount = popcount(RightXOR),

    NewCount = if
        LeftPopcount == K andalso RightPopcount == K ->
            Count + 1;
        true ->
            Count
    end,
    count_splits(I + 1, N, K, PrefixXOR_tuple, TotalXOR, NewCount);
count_splits(_I, _N, _K, _PrefixXOR_tuple, _TotalXOR, Count) ->
    Count.