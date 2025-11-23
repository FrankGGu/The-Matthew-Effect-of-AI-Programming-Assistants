-module(solution).
-export([max_amount/1]).

max_amount(Conversions) ->
    Max = 0,
    lists:foldl(fun({A, B, R}, Acc) ->
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A andalso R2 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(A, 1, Conversions) of
                            false -> ok;
                            {A, B1, R1} when B1 == B andalso R1 == R -> ok;
                            _ -> ok
                        end,
                        case lists:keyfind(B, 1, Conversions) of
                            false -> ok;
                            {B, A1, R2} when A1 == A and......
                    end, Max).