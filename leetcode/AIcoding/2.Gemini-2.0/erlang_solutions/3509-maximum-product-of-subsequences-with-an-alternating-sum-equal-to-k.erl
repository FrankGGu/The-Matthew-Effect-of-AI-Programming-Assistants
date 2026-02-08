-module(maximum_product_alternating_sum).
-export([solve/1]).

solve(K) ->
    solve_helper(K, [], 1).

solve_helper(0, Seq, Prod) ->
    {Prod, Seq};
solve_helper(K, _Seq, _Prod) when K < 0 ->
    {-1, []};
solve_helper(_K, _Seq, _Prod) when _K > 100 ->
    {-1, []}; % Add this to avoid infinite loop

solve_helper(K, Seq, Prod) ->
    case K rem 2 of
        0 ->
            A = solve_helper(K + 1, [1 | Seq], -Prod),
            B = solve_helper(K - 2, [-2 | Seq], -Prod),
            case A of
                {-1, _} ->
                    B;
                {ProdA, SeqA} ->
                    case B of
                        {-1, _} ->
                            A;
                        {ProdB, SeqB} ->
                            if ProdA > ProdB then
                                A
                            else
                                B
                            end
                    end
            end;
        1 ->
            A = solve_helper(K + 1, [1 | Seq], -Prod),
            B = solve_helper(K - 2, [-2 | Seq], -Prod),
            case A of
                {-1, _} ->
                    B;
                {ProdA, SeqA} ->
                    case B of
                        {-1, _} ->
                            A;
                        {ProdB, SeqB} ->
                            if ProdA > ProdB then
                                A
                            else
                                B
                            end
                    end
            end
    end.

maximum_product(K) ->
    {Prod, _} = solve(K),
    case Prod of
        -1 -> 0;
        _ -> Prod
    end.