-module(longest_happy_string).
-export([longest_happy_string/3]).

longest_happy_string(A, B, C) ->
    longest_happy_string(A, B, C, "", []).

longest_happy_string(0, 0, 0, Acc, _) ->
    lists:reverse(Acc);
longest_happy_string(A, B, C, Acc, LastTwo) ->
    Candidates = [{A, $a}, {B, $b}, {C, $c}],
    SortedCandidates = lists:sort(fun({X1, _}, {X2, _}) -> X1 > X2 end, Candidates),
    case SortedCandidates of
        [{0, _}, {0, _}, {0, _}] ->
            lists:reverse(Acc);
        [{N1, C1}, {N2, C2}, _] ->
            case LastTwo of
                [C1, C1] ->
                    case N2 > 0 of
                        true ->
                            longest_happy_string(N1, N2 - 1, C, [C2 | Acc], [C2 | lists:sublist(Acc, 2)]);
                        false ->
                            lists:reverse(Acc)
                    end;
                _ ->
                    longest_happy_string(N1 - 1, N2, C, [C1 | Acc], [C1 | lists:sublist(Acc, 2)])
            end
    end.