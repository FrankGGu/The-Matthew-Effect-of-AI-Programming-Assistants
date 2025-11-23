-module(solution).
-export([least_ops_to_express_number/2]).

least_ops_to_express_number(X, Target) ->
    {Cost, _Memo} = solve(Target, X, #{}),
    Cost.

solve(Target, X, Memo) ->
    if Target =:= 0 -> {0, Memo};
       X =:= 1 ->
           Cost = if Target =:= 1 -> 1;
                     true -> 2 * Target - 1 % Cost for 1+1+...+1 (Target times)
                  end,
           {Cost, maps:put(Target, Cost, Memo)};
       true ->
           case maps:find(Target, Memo) of
               {ok, Cost} -> {Cost, Memo};
               _ ->
                   PlaceholderCost = 10000000000000000000000000000000000000000000000000000,
                   Memo_with_placeholder = maps:put(Target, PlaceholderCost, Memo),

                   K = find_k(X, Target),
                   X_pow_K = power(X, K),

                   Cost_X_pow_K = cost_x_pow(K, X),

                   Q = Target div X_pow_K,
                   Rem = Target rem X_pow_K,

                   Cost_Q_val_K = if Q =:= 0 -> 0;
                                     Q =:= 1 -> Cost_X_pow_K;
                                     true -> Q * Cost_X_pow_K + (Q - 1)
                                  end,
                   {Res1_rem_cost, Memo1} = solve(Rem, X, Memo_with_placeholder),
                   Res1 = if Q =:= 0 -> Res1_rem_cost;
                             Rem =:= 0 -> Cost_Q_val_K;
                             true -> Cost_Q_val_K + 1 + Res1_rem_cost
                          end,

                   Cost_Q_plus_1_val_K = if Q =:= 0 -> Cost_X_pow_K;
                                            true -> (Q + 1) * Cost_X_pow_K + Q
                                         end,
                   Rem_prime = (Q + 1) * X_pow_K - Target,
                   {Res2_rem_prime_cost, Memo2} = solve(Rem_prime, X, Memo1),
                   Res2 = if Rem_prime =:= 0 -> Cost_Q_plus_1_val_K;
                             true -> Cost_Q_plus_1_val_K + 1 + Res2_rem_prime_cost
                          end,

                   MinCost = min(Res1, Res2),
                   {MinCost, maps:put(Target, MinCost, Memo2)}
           end.

cost_x_pow(K, X) ->
    if K =:= 0 ->
           if X =:= 1 -> 1;
              true -> 3
           end;
       true ->
           2 * K - 1
    end.

find_k(X, Target) ->
    K = 0,
    X_pow_K = 1,
    find_k_loop(X, Target, K, X_pow_K).

find_k_loop(X, Target, K, X_pow_K) ->
    if X_pow_K > Target div X ->
        K;
    true ->
        find_k_loop(X, Target, K + 1, X_pow_K * X)
    end.

power(Base, Exp) ->
    power_acc(Base, Exp, 1).

power_acc(_Base, 0, Acc) -> Acc;
power_acc(Base, Exp, Acc) -> power_acc(Base, Exp - 1, Acc * Base).