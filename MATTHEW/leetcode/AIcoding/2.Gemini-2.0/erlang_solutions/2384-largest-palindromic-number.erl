-module(largest_palindrome).
-export([largest_palindrome/1]).

largest_palindrome(Digits) ->
    Counts = lists:foldl(fun(Digit, Acc) ->
                                 case maps:is_key(Digit, Acc) of
                                     true -> maps:update(Digit, maps:get(Digit, Acc) + 1, Acc);
                                     false -> maps:put(Digit, 1, Acc)
                                 end
                             end, #{}, Digits),
    {Center, RemainingCounts} = find_center(Counts),
    {Prefix, FinalCounts} = build_prefix(RemainingCounts, []),
    case Prefix of
        [] ->
            case Center of
                none -> "0";
                _ -> integer_to_list(Center)
            end;
        _ ->
            TrimmedPrefix = trim_leading_zeros(Prefix),
            case Center of
                none -> TrimmedPrefix ++ lists:reverse(TrimmedPrefix);
                _ -> TrimmedPrefix ++ integer_to_list(Center) ++ lists:reverse(TrimmedPrefix)
            end
    end.

find_center(Counts) ->
    ReversedDigits = lists:reverse(lists:seq(0, 9)),
    find_center_helper(ReversedDigits, Counts).

find_center_helper([], _) ->
    {none, #{}};
find_center_helper([Digit | Rest], Counts) ->
    case maps:is_key(Digit, Counts) of
        true ->
            case maps:get(Digit, Counts) rem 2 of
                1 -> {Digit, maps:update(Digit, maps:get(Digit, Counts) - 1, Counts)};
                _ -> find_center_helper(Rest, Counts)
            end;
        false -> find_center_helper(Rest, Counts)
    end.

build_prefix(Counts, Acc) ->
    ReversedDigits = lists:reverse(lists:seq(1, 9)),
    build_prefix_helper(ReversedDigits, Counts, Acc).

build_prefix_helper([], Counts, Acc) ->
    {Acc, Counts};
build_prefix_helper([Digit | Rest], Counts, Acc) ->
    case maps:is_key(Digit, Counts) of
        true ->
            Count = maps:get(Digit, Counts);
            if
                Count >= 2 ->
                    NewCounts = maps:update(Digit, Count - 2, Counts),
                    build_prefix_helper([Digit | Rest], NewCounts, [Digit | Acc]);
                true ->
                    build_prefix_helper(Rest, Counts, Acc)
            end;
        false ->
            build_prefix_helper(Rest, Counts, Acc)
    end.

trim_leading_zeros(Prefix) ->
    trim_leading_zeros_helper(Prefix, []).

trim_leading_zeros_helper([], Acc) ->
  case Acc of
      [] -> "0";
      _ -> lists:reverse(Acc)
  end;
trim_leading_zeros_helper([0 | Rest], Acc) ->
    trim_leading_zeros_helper(Rest, Acc);
trim_leading_zeros_helper([Digit | Rest], Acc) ->
    lists:reverse(Acc) ++ [Digit | Rest].