-module(solution).
-export([find_champion/1]).

find_champion(competitions) ->
    case competitions of
        [] -> undefined;
        _ ->
            {Champion, _} = lists:foldl(fun({A, B}, {Max, Count}) ->
                case lists:member(A, [Max]) of
                    true -> {Max, Count + 1};
                    false -> case lists:member(B, [Max]) of
                        true -> {Max, Count - 1};
                        false -> case Count of
                            0 -> {A, 1};
                            _ -> {Max, Count}
                        end
                    end
                end, {hd(competitions), 0}, competitions),
            Champion
    end.