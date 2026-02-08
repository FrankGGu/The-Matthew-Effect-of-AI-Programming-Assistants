-module(solution).
-export([capitalize_title/1]).

capitalize_title(Title) ->
    TitleList = string:split(Title, " "),
    CapitalizedList = lists:map(fun Word ->
        case string:length(Word) of
            0 -> "";
            Len when Len > 2 -> string:capitalize(Word);
            _ -> string:lower(Word)
        end
    end, TitleList),
    string:join(CapitalizedList, " ").