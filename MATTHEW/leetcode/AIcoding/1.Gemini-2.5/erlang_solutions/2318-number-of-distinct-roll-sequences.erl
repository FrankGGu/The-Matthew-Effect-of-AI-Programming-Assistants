-module(solution).
-export([distinct_roll_sequences/1]).

distinct_roll_sequences(N) ->
    MOD = 1000000007,

    Gcd = fun G(A, 0) -> A;
              G(A, B) -> G(B, A rem B)
          end,

    Coprime = fun(A, B) -> Gcd(A, B) == 1 end,

    UpdateMatrix = fun(Matrix, RowIdx, ColIdx, Value) ->
        lists:replace_nth(RowIdx, lists:replace_nth(ColIdx, Value, lists:nth(RowIdx, Matrix)), Matrix)
    end,

    InitialDP = lists:duplicate(6, lists:duplicate(6, 0)),

    if N == 1 ->
        6;
    true ->
        DP_Current = lists:foldl(
            fun(I, AccDP) ->
                lists:foldl(
                    fun(J, AccDP2) ->
                        if I /= J andalso Coprime(I, J) ->
                            UpdateMatrix(AccDP2, I, J, 1);
                        true ->
                            AccDP2
                        end
                    end, AccDP, lists:seq(1, 6))
            end, InitialDP, lists:seq(1, 6)),

        FinalDP = lists:foldl(
            fun(_K, CurrentDP) ->
                NewDP = InitialDP,
                lists:foldl(
                    fun(CurrentRoll, AccNewDP) ->
                        lists:foldl(
                            fun(LastRoll, AccNewDP2) ->
                                if CurrentRoll /= LastRoll andalso Coprime(CurrentRoll, LastRoll) ->
                                    SumForCell = lists:foldl(
                                        fun(PrevRoll, AccSum) ->
                                            Val = lists:nth(PrevRoll, lists:nth(LastRoll, CurrentDP)),
                                            (AccSum + Val) rem MOD
                                        end, 0, lists:seq(1, 6)),
                                    UpdateMatrix(AccNewDP2, CurrentRoll, LastRoll, SumForCell);
                                true ->
                                    AccNewDP2
                                end
                            end, AccNewDP, lists:seq(1, 6))
                    end, NewDP, lists:seq(1, 6))
            end, DP_Current, lists:seq(3, N)),

        Total = lists:foldl(
            fun(RowList, AccTotal) ->
                lists:foldl(fun(Val, AccTotal2) -> (AccTotal2 + Val) rem MOD end, AccTotal, RowList)
            end, 0, FinalDP),
        Total
    end.