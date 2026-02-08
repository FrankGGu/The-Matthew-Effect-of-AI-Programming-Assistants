-module(solution).
-export([decode_at_index/2]).

decode_at_index(S, K) ->
    Length = length(S),
    {Index, DecodedLength} = decode_index(S, K, Length),
    {Index, DecodedLength}.

decode_index([], _, _) -> {0, 0};
decode_index([H | T], K, Length) ->
    case H of
        $0 -> decode_index(T, K, Length);
        $a to $z -> 
            NewLength = Length - 1,
            if 
                NewLength + 1 == K -> {1, 1}; 
                NewLength + 1 < K -> decode_index(T, K - (NewLength + 1), NewLength); 
                true -> {0, 0}
            end;
        _ -> 
            {NewIndex, NewLength} = decode_index(T, K div (ord(H) - ord($0) + 1), Length),
            if 
                K rem (ord(H) - ord($0) + 1) == 0 -> {NewIndex, NewLength};
                true -> {0, 0}
            end
    end.