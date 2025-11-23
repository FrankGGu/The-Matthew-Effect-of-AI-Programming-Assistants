%% Definition for array rotation.
%% -spec rotate(nums :: [integer()], k :: integer()) -> [integer()].

rotate(Nums, K) ->
    N = length(Nums),
    K = K rem N,
    rotate_list(Nums, N - K, N - 1).

rotate_list([], _, _) -> [];
rotate_list([H | T], 0, _) -> [H | T];
rotate_list([H | T], 0, End) -> [H | rotate_list(T, 0, End - 1)];
rotate_list([H | T], Count, End) when Count > 0 ->
    rotate_list(T ++ [H], Count - 1, End).
