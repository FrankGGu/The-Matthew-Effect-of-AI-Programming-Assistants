-module(split_message).
-export([splitMessage/2]).

splitMessage(message, limit) ->
    Len = length(message),
    {Parts, NumParts} = calculate_parts(Len, limit),
    generate_messages(message, limit, Parts, 1, NumParts, []).

calculate_parts(Len, Limit) ->
    lists:foldl(fun(NumParts, {Parts, TotalLength}) ->
                        PartLength = length(integer_to_list(NumParts)) + 3,
                        NewTotalLength = TotalLength + length(integer_to_list(NumParts)) + 3,
                        CharsPerPart = Limit - PartLength,
                        if CharsPerPart > 0 ->
                            NewParts = Parts + (Len + NewTotalLength -1) div (NumParts * CharsPerPart),
                            if NewParts =:= NumParts then
                                {Parts, TotalLength}
                            else
                                {NewParts, TotalLength}
                            end
                        else
                            {Parts, TotalLength}
                        end
                end, {1, 0}, lists:seq(1, Len)),

    {Parts, Parts}.

generate_messages(Message, Limit, Parts, PartNum, NumParts, Acc) ->
    PartString = integer_to_list(PartNum) ++ "<" ++ integer_to_list(NumParts) ++ ">",
    PartLength = length(PartString),
    CharsPerPart = Limit - PartLength,
    if CharsPerPart > 0 ->
        Start = (PartNum - 1) * CharsPerPart + 1,
        End = min(PartNum * CharsPerPart, length(Message)),
        SubMessage = lists:sublist(Message, Start, End - Start + 1),
        NewMessage = SubMessage ++ PartString,
        if PartNum < NumParts then
            generate_messages(Message, Limit, Parts, PartNum + 1, NumParts, [NewMessage | Acc])
        else
            lists:reverse([NewMessage | Acc])
        end
    else
        []
    end.