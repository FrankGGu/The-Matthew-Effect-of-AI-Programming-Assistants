-module(string_compression_ii).
-export([get_length_of_optimal_compression/2]).

get_length_of_optimal_compression(S, K) ->
    Len = length(S),
    Memo = dict:new(),
    get_length_of_optimal_compression_helper(S, 0, K, Memo).

get_length_of_optimal_compression_helper(S, Start, K, Memo) ->
    case dict:find({Start, K}, Memo) of
        {ok, Val} ->
            Val;
        error ->
            Len = length(S),
            if Start >= Len then
                0
            else if K =:= 0 then
                compress(lists:sublist(S, Start+1, Len - Start))
            else
                Ans1 = get_length_of_optimal_compression_helper(S, Start + 1, K - 1, Memo),
                Ans2 = compress_with_removal(S, Start, K),

                Ans = min(Ans1, Ans2),
                dict:store({Start, K}, Ans, Memo),
                Ans
            end
    end.

compress_with_removal(S, Start, K) ->
    Len = length(S),
    Best = infinity,
    for(End <- Start to Len -1 , KLeft <- 0 to K ) do
        if (End-Start+1) > KLeft then
            Sublist = lists:sublist(S, Start+1, End - Start +1),
            Removed = K - KLeft,
            NewStart = End + 1,

            CompressedLength = compress(Sublist) ,

            RemainingLength = get_length_of_optimal_compression_helper(S, NewStart, Removed, dict:new()),
            TotalLength = CompressedLength + RemainingLength,

            Best = min(Best, TotalLength)

        end
    end,
    Best.

compress(S) ->
    Len = length(S),
    if Len =:= 0 then
        0
    else
        {Count, Char, Rest} = count_consecutive(S),
        if Count =:= 1 then
            1 + compress(Rest)
        else
            integer_to_list_length(Count) + 1 + compress(Rest)
        end
    end.

count_consecutive(S) ->
    count_consecutive_helper(S, hd(S), 0).

count_consecutive_helper([H|T], Char, Count) ->
    if H =:= Char then
        count_consecutive_helper(T, Char, Count + 1)
    else
        {Count, Char, [H|T]}
    end;
count_consecutive_helper([], Char, Count) ->
    {Count, Char, []}.

integer_to_list_length(N) ->
    if N < 10 then
        1
    else if N < 100 then
        2
    else if N < 1000 then
        3
    else
        4
    end.