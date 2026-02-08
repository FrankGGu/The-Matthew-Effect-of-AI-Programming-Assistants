-module(thousand_separator).
-export([format/1]).

format(N) ->
    format(N, []).

format(0, Acc) ->
    lists:reverse(Acc);
format(N, Acc) ->
    Digit = N rem 10,
    Rest = N div 10,
    case Acc of
        [] ->
            format(Rest, [Digit]);
        _ ->
            case length(Acc) rem 3 of
                0 ->
                    format(Rest, [$., Digit]);
                _ ->
                    format(Rest, [Digit | Acc])
            end
    end.

format_int(N) when N < 0 ->
    [$- | format(-N)];
format_int(N) ->
    format(N).

format([]) ->
    "0";
format([H | T]) ->
    lists:flatten([integer_to_list(H) | [[$, | integer_to_list(X)] || X <- T]]).