-module(solution).
-export([findBeautifulIndices/4]).

findBeautifulIndices(S, A, B, K) ->
    A_indices = get_all_indices(S, A),
    B_indices = get_all_indices(S, B),

    lists:filter(fun(I) ->
        lists:any(fun(J) -> abs(I - J) =< K end, B_indices)
    end, A_indices).

get_all_indices(Text, Pattern) ->
    get_all_indices(Text, Pattern, 1, []).

get_all_indices(Text, Pattern, StartPos, Acc) ->
    case string:find(Text, Pattern, StartPos) of
        nomatch -> lists:reverse(Acc);
        {MatchStart, _MatchLen} ->
            ActualIdx = MatchStart - 1,
            get_all_indices(Text, Pattern, MatchStart + 1, [ActualIdx | Acc])
    end.