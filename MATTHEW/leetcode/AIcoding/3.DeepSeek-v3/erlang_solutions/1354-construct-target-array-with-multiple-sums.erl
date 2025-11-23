-module(solution).
-export([is_possible/1]).

is_possible(Target) ->
    case lists:max(Target) of
        1 -> true;
        Max ->
            Sum = lists:sum(Target),
            case Max > Sum - Max of
                true ->
                    case lists:keytake(Max, 1, lists:zip(Target, lists:seq(1, length(Target)))) of
                        {value, {Max, I}, Rest} ->
                            NewMax = Max rem (Sum - Max),
                            if
                                NewMax < 1 -> false;
                                true ->
                                    NewTarget = lists:keyreplace(I, 2, Rest, {NewMax, I}),
                                    is_possible([X || {X, _} <- NewTarget])
                            end;
                        false -> false
                    end;
                false -> false
            end
    end.