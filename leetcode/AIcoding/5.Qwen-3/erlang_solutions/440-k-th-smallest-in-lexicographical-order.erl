-module(kth_smallest_lexicographical_order).
-export([find_kth_number/2]).

find_kth_number(N, K) ->
    find_kth_number(N, K, 1, 1).

find_kth_number(_, K, _, Count) when Count == K ->
    Count;
find_kth_number(N, K, Current, Count) ->
    Next = Current * 10,
    if
        Next > N ->
            find_kth_number(N, K, Current + 1, Count + 1);
        true ->
            Step = min(N, Next + 9) - Next + 1,
            if
                Count + Step <= K ->
                    find_kth_number(N, K, Next, Count + Step);
                true ->
                    find_kth_number(N, K, Next, Count)
            end
    end.