-module(solution).
-export([number_of_lines/2]).

number_of_lines(Widths, S) ->
    WidthsList = lists:map(fun(X) -> element(X, Widths) end, string:to_list(S)),
    TotalWidth = lists:sum(WidthsList),
    Lines = TotalWidth div 100,
    RemainingWidth = TotalWidth rem 100,
    {Lines + (if RemainingWidth > 0 -> 1; true -> 0 end), RemainingWidth}.