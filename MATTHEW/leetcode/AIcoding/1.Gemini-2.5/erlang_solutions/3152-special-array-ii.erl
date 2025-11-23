-module(solution).
-export([special_array_ii/2]).

special_array_ii(Nums, Queries) ->
    ParityBreaks = build_parity_breaks(Nums),
    PrefixSumsArray = build_prefix_sums_array(ParityBreaks),

    lists:map(fun([From, To]) ->
        FromVal = array:get(From, PrefixSumsArray),
        ToVal = array:get(To, PrefixSumsArray),
        (ToVal - FromVal) == 0
    end, Queries).

build_parity_breaks([_]) -> [];
build_parity_breaks([H1, H2 | T]) ->
    Parity1 = H1 rem 2,
    Parity2 = H2 rem 2,
    Break = if Parity1 == Parity2 -> 1;
              true -> 0
            end,
    [Break | build_parity_breaks([H2 | T])].

build_prefix_sums_array(ParityBreaks) ->
    PrefixSumsList = [0 | build_prefix_sums_recursive(ParityBreaks, 0)],
    array:from_list(PrefixSumsList).

build_prefix_sums_recursive([], _CurrentSum) -> [];
build_prefix_sums_recursive([H | T], CurrentSum) ->
    NewSum = CurrentSum + H,
    [NewSum | build_prefix_sums_recursive(T, NewSum)].