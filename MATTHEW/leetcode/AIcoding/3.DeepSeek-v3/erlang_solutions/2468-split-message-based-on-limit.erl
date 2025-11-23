-module(split_message).
-export([split_message/2]).

split_message(Message, Limit) ->
    case Limit =< 5 of
        true -> [];
        false -> split(Message, Limit, 1, [])
    end.

split(Message, Limit, I, Acc) ->
    Suffix = "<" ++ integer_to_list(I) ++ "/" ++ ">",
    SuffixLen = length(Suffix),
    PrefixLen = Limit - SuffixLen,
    case PrefixLen =< 0 of
        true -> [];
        false ->
            case Message of
                [] -> lists:reverse(Acc);
                _ ->
                    {Prefix, Rest} = take_prefix(Message, PrefixLen),
                    Part = Prefix ++ Suffix,
                    split(Rest, Limit, I + 1, [Part | Acc])
            end
    end.

take_prefix(Str, Len) ->
    take_prefix(Str, Len, []).

take_prefix([], _, Acc) -> {lists:reverse(Acc), []};
take_prefix(Str, 0, Acc) -> {lists:reverse(Acc), Str};
take_prefix([C | Rest], Len, Acc) ->
    take_prefix(Rest, Len - 1, [C | Acc]).