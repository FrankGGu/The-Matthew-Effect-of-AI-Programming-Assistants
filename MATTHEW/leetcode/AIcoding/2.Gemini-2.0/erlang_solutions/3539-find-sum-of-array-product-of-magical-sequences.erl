-module(magical_sequences).
-export([sum_of_array_products/1]).

sum_of_array_products(Nums) ->
    Len = length(Nums),
    {SortedNums, _} = lists:sort(lists:zip(Nums, lists:seq(1, Len))),

    parent(I, N) ->
        case I > 1 of
            true -> I div 2;
            false -> 0
        end;

    left(I, N) ->
        case 2 * I =< N of
            true -> 2 * I;
            false -> 0
        end;

    right(I, N) ->
        case 2 * I + 1 =< N of
            true -> 2 * I + 1;
            false -> 0
        end;

    build_max_heap(A, N) ->
        build_max_heap(A, N, N div 2);

    build_max_heap(A, N, I) when I >= 1 ->
        A1 = max_heapify(A, N, I),
        build_max_heap(A1, N, I - 1);
    build_max_heap(A, N, 0) ->
        A;

    max_heapify(A, N, I) ->
        L = left(I, N),
        R = right(I, N),
        Largest =
            case L > 0 andalso element(A, L) > element(A, I) of
                true -> L;
                false -> I
            end,
        Largest2 =
            case R > 0 andalso element(A, R) > element(A, Largest) of
                true -> R;
                false -> Largest
            end,
        case Largest2 =/= I of
            true ->
                {VI, _} = lists:nth(I, A),
                {VL, _} = lists:nth(Largest2, A),
                A1 = lists:replace(I, {VL,0}, A),
                A2 = lists:replace(Largest2, {VI,0}, A1),
                max_heapify(A2, N, Largest2);
            false ->
                A
        end;

    extract_max(A, N) ->
        case N > 0 of
            true ->
                {Max, _} = element(A, 1),
                {Last, _} = element(A, N),
                A1 = lists:replace(1, {Last,0}, A),
                A2 = lists:sublist(A1, 1, N-1),
                {A2, N-1, Max};
            false ->
                {A, 0, 0}
        end;

    element(A, I) ->
       case length(A) >= I of
          true ->
             {Val, _} = lists:nth(I, A),
             Val;
          false ->
             0
       end,

    find_left(Idx, Nums) ->
        find_left(Idx, Nums, []);

    find_left(Idx, Nums, Acc) ->
        case Idx =< 0 of
            true ->
                Acc;
            false ->
                case lists:nth(Idx, Nums) < 0 of
                    true ->
                        Acc;
                    false ->
                        find_left(Idx - 1, Nums, [lists:nth(Idx, Nums) | Acc])
                end
        end,

    find_right(Idx, Nums) ->
        find_right(Idx, Nums, []);

    find_right(Idx, Nums, Acc) ->
        case Idx > length(Nums) of
            true ->
                Acc;
            false ->
                case lists:nth(Idx, Nums) < 0 of
                    true ->
                        Acc;
                    false ->
                        find_right(Idx + 1, Nums, [lists:nth(Idx, Nums) | Acc])
                end
        end,

    get_product(SubList) ->
        lists:foldl(fun(X, Acc) -> X * Acc end, 1, SubList),

    calculate_sum(Nums) ->
        Len = length(Nums),
        calculate_sum(Nums, 1, 0, Len, []),

    calculate_sum(Nums, Idx, Sum, Len, Acc) when Idx > Len ->
        lists:foldl(fun(X, S) -> (X + S) rem 1000000007 end, 0, Acc);

    calculate_sum(Nums, Idx, Sum, Len, Acc) ->
        Left = find_left(Idx - 1, Nums),
        Right = find_right(Idx + 1, Nums),
        SubList = [lists:nth(Idx, Nums) | Left ++ Right],
        Product = get_product(SubList),
        calculate_sum(Nums, Idx + 1, Sum, Len, [Product | Acc]).

    calculate_sum(Nums).