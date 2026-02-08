-module(lemonade_change).
-export([lemonade_change/1]).

lemonade_change(Bills) ->
    lemonade_change(Bills, 0, 0).

lemonade_change([], Five, Ten) ->
    true;
lemonade_change([Bill | Rest], Five, Ten) ->
    case Bill of
        5 ->
            lemonade_change(Rest, Five + 1, Ten);
        10 ->
            if Five > 0 then
                lemonade_change(Rest, Five - 1, Ten + 1)
            else
                false
            end;
        20 ->
            if Ten > 0 then
                if Five > 0 then
                    lemonade_change(Rest, Five - 1, Ten - 1)
                else
                    false
                end
            else
                if Five >= 3 then
                    lemonade_change(Rest, Five - 3, Ten)
                else
                    false
                end
            end
    end.