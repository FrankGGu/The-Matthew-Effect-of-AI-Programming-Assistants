-module(solution).
-export([num_fillings/1]).

num_fillings(N) ->
    num_fillings(N, 1, 1).

num_fillings(N, Row, Col) when Row > N ->
    1;
num_fillings(N, Row, Col) when Col > N ->
    num_fillings(N, Row + 1, 1);
num_fillings(N, Row, Col) ->
    case {Row rem 2, Col rem 2} of
        {0, 0} -> 0;
        {0, 1} -> 0;
        {1, 0} -> 0;
        _ ->
            case {Row, Col} of
                {1, 1} -> 1 * num_fillings(N, Row, Col + 1);
                {1, N} -> 1 * num_fillings(N, Row, Col + 1);
                {N, 1} -> 1 * num_fillings(N, Row, Col + 1);
                {N, N} -> 1 * num_fillings(N, Row, Col + 1);
                _ ->
                    case {Row rem 2, Col rem 2} of
                        {1, 1} -> 1 * num_fillings(N, Row, Col + 1);
                        _ -> 2 * num_fillings(N, Row, Col + 1)
                    end
            end
    end.