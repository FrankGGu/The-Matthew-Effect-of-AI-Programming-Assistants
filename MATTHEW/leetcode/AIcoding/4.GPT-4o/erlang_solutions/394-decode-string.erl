-module(solution).
-compile([export_all]).

% Decode the string based on the encoding rule
decode_string(S) -> decode_string(S, []).

decode_string([], Acc) -> lists:reverse(Acc);
decode_string([S | Rest], Acc) when S =:= $] -> decode_string(Rest, Acc);
decode_string([S | Rest], Acc) when S =:= $[ -> decode_string(Rest, [{S, []} | Acc]);
decode_string([S | Rest], [{`[`, SubAcc} | Stack]) when S =:= $] -> 
    NewSub = lists:reverse(SubAcc),
    case Stack of
        [{`[`, LastAcc} | _] -> decode_string(Rest, [LastAcc | Acc])
    end;
decode_string([S | Rest], Acc) -> decode_string(Rest, [S | Acc]).
