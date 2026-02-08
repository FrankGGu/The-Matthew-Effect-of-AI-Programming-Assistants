-module(solution).
-export([find_in_mountain_array/2]).

find_in_mountain_array(Target, Mountain) ->
    case find_peak(Mountain, 0, length(Mountain) - 1) of
        {ok, Peak} ->
            case binary_search(Mountain, Target, 0, Peak) of
                {ok, Index} -> Index;
                not_found ->
                    case binary_search(Mountain, Target, Peak + 1, length(Mountain) - 1) of
                        {ok, Index} -> Index;
                        not_found -> -1
                    end
            end;
        _ -> -1
    end.

find_peak(Mountain, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    case (Mountain[Mid] < Mountain[Mid + 1]) of
        true -> find_peak(Mountain, Mid + 1, High);
        false -> find_peak(Mountain, Low, Mid)
    end;
find_peak(_, Low, High) -> {ok, Low}.

binary_search(Mountain, Target, Low, High) ->
    case Low > High of
        true -> not_found;
        false ->
            Mid = (Low + High) div 2,
            case (Mountain[Mid] == Target) of
                true -> {ok, Mid};
                false ->
                    case (Mountain[Mid] < Target) of
                        true -> binary_search(Mountain, Target, Mid + 1, High);
                        false -> binary_search(Mountain, Target, Low, Mid - 1)
                    end
            end
    end.

not_found -> not_found.