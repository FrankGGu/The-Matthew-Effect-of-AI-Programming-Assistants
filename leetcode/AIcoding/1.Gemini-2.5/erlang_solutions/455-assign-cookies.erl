-module(solution).
-export([findContentChildren/2]).

findContentChildren(G, S) ->
    SortedG = lists:sort(G),
    SortedS = lists:sort(S),
    assign_cookies(SortedG, SortedS, 0).

assign_cookies([], _S, Count) ->
    Count;
assign_cookies(_G, [], Count) ->
    Count;
assign_cookies([GHead | GTail], [SHead | STail], Count) ->
    if
        SHead >= GHead ->
            assign_cookies(GTail, STail, Count + 1);
        true ->
            assign_cookies([GHead | GTail], STail, Count)
    end.