-module(solution).
-export([largest_word_count/1]).

largest_word_count(messages) ->
    lists:foldl(
        fun(Message, {MaxCount, MaxWord}) ->
            Words = string:tokens(Message, " "),
            Count = length(Words),
            case Count > MaxCount of
                true ->
                    {Count, Message};
                false ->
                    case Count == MaxCount of
                        true ->
                            case Message > MaxWord of
                                true ->
                                    {Count, Message};
                                false ->
                                    {MaxCount, MaxWord}
                            end;
                        false ->
                            {MaxCount, MaxWord}
                    end
            end
        end,
        {0, ""},
        messages
    ).

largest_word_count(Messages) ->
    lists:last(lists:keysort(1,
        [ {length(string:tokens(M, " ")), M} || M <- Messages])).