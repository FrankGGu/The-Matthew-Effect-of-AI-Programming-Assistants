-module(longest_happy_string).
-export([longest_diverse_string/1]).

longest_diverse_string(A) ->
    longest_diverse_string(A, [], 0, 0, 0).

longest_diverse_string([], Result, _, _, _) ->
    lists:reverse(Result);
longest_diverse_string([C | Rest], Result, CountA, CountB, CountC) ->
    case C of
        $a ->
            if CountA >= 2 -> 
                case {CountB, CountC} of
                    {0, 0} -> longest_diverse_string(Rest, Result, 0, 0, 0);
                    _ -> 
                        case lists:member($b, [C | Rest]) andalso lists:member($c, [C | Rest]) of
                            true -> 
                                case CountB > CountC of
                                    true -> longest_diverse_string(Rest, [C | Result], 0, CountB + 1, CountC);
                                    false -> longest_diverse_string(Rest, [C | Result], 0, CountB, CountC + 1)
                                end;
                            false -> longest_diverse_string(Rest, Result, 0, 0, 0)
                        end;
                end;
            true ->
                longest_diverse_string(Rest, [C | Result], CountA + 1, CountB, CountC)
        end;
    case C of
        $b ->
            if CountB >= 2 -> 
                case {CountA, CountC} of
                    {0, 0} -> longest_diverse_string(Rest, Result, 0, 0, 0);
                    _ -> 
                        case lists:member($a, [C | Rest]) andalso lists:member($c, [C | Rest]) of
                            true -> 
                                case CountA > CountC of
                                    true -> longest_diverse_string(Rest, [C | Result], CountA + 1, 0, CountC);
                                    false -> longest_diverse_string(Rest, [C | Result], CountA, 0, CountC + 1)
                                end;
                            false -> longest_diverse_string(Rest, Result, 0, 0, 0)
                        end;
                end;
            true ->
                longest_diverse_string(Rest, [C | Result], CountA, CountB + 1, CountC)
        end;
    case C of
        $c ->
            if CountC >= 2 -> 
                case {CountA, CountB} of
                    {0, 0} -> longest_diverse_string(Rest, Result, 0, 0, 0);
                    _ -> 
                        case lists:member($a, [C | Rest]) andalso lists:member($b, [C | Rest]) of
                            true -> 
                                case CountA > CountB of
                                    true -> longest_diverse_string(Rest, [C | Result], CountA + 1, CountB, 0);
                                    false -> longest_diverse_string(Rest, [C | Result], CountA, CountB + 1, 0)
                                end;
                            false -> longest_diverse_string(Rest, Result, 0, 0, 0)
                        end;
                end;
            true ->
                longest_diverse_string(Rest, [C | Result], CountA, CountB, CountC + 1)
        end.