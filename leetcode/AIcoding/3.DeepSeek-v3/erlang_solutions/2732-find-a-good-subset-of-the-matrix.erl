-module(solution).
-export([good_subset/1]).

good_subset(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            case Rows == 1 andalso lists:all(fun(X) -> X == 0 end, hd(Matrix)) of
                true -> [0];
                false ->
                    case find_zero_row(Matrix, 0) of
                        {found, Row} -> [Row];
                        not_found ->
                            case find_complementary_rows(Matrix, 0, 1) of
                                {found, R1, R2} -> [R1, R2];
                                not_found -> []
                            end
                    end
            end
    end.

find_zero_row([Row | Rest], Index) ->
    case lists:all(fun(X) -> X == 0 end, Row) of
        true -> {found, Index};
        false -> find_zero_row(Rest, Index + 1)
    end;
find_zero_row([], _) -> not_found.

find_complementary_rows([Row1 | Rest], I1, I2) ->
    case check_complementary(Row1, lists:nth(I2 + 1, [Row1 | Rest])) of
        true -> {found, I1, I2};
        false ->
            case I2 + 1 < length([Row1 | Rest]) of
                true -> find_complementary_rows([Row1 | Rest], I1, I2 + 1);
                false ->
                    case I1 + 1 < length(Rest) of
                        true -> find_complementary_rows(Rest, I1 + 1, I1 + 2);
                        false -> not_found
                    end
            end
    end;
find_complementary_rows(_, _, _) -> not_found.

check_complementary(Row1, Row2) ->
    lists:all(fun({X, Y}) -> X * Y == 0 end, lists:zip(Row1, Row2)).