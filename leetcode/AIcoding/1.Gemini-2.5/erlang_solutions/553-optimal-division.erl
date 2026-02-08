-module(solution).
-export([optimalDivision/1]).

optimalDivision(Nums) ->
    N = length(Nums),
    case N of
        1 ->
            integer_to_list(hd(Nums));
        2 ->
            integer_to_list(hd(Nums)) ++ "/" ++ integer_to_list(hd(tl(Nums)));
        _ -> % N >= 3
            integer_to_list(hd(Nums)) ++ "/(" ++ join_nums_with_slash(tl(Nums)) ++ ")"
    end.

join_nums_with_slash([H]) -> integer_to_list(H);
join_nums_with_slash([H | T]) -> integer_to_list(H) ++ "/" ++ join_nums_with_slash(T).