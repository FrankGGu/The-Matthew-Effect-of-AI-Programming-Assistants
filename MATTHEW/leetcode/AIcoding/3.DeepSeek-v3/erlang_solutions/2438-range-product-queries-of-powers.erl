-module(solution).
-export([product_queries/2]).

product_queries(N, Queries) ->
    Powers = get_powers(N),
    lists:map(fun(Query) ->
        [L, R] = Query,
        SubList = lists:sublist(Powers, L + 1, R - L + 1),
        lists:foldl(fun(X, Acc) -> (Acc * X) rem 1000000007 end, 1, SubList)
    end, Queries).

get_powers(N) ->
    get_powers(N, 0, []).

get_powers(0, _Bit, Acc) ->
    lists:reverse(Acc);
get_powers(N, Bit, Acc) ->
    case (N band 1) =:= 1 of
        true -> get_powers(N bsr 1, Bit + 1, [trunc(math:pow(2, Bit)) | Acc]);
        false -> get_powers(N bsr 1, Bit + 1, Acc)
    end.