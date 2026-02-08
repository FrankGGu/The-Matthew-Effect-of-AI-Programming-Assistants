-module(solution).
-export([smallest_substring/1]).

smallest_substring(S) ->
    N = string:len(S),
    MinLen = N + 1,
    MinSubstr = <<>>,
    Loop = fun(Idx, LastChar, Count, StartIdx) when Idx < N ->
        Char = string:substr(S, Idx + 1, 1),
        case Char of
            LastChar ->
                Loop(Idx + 1, Char, Count + 1, StartIdx);
            _ when Count > 0 ->
                SubstrLen = Idx - StartIdx + 1,
                if 
                    SubstrLen < MinLen ->
                        MinLen = SubstrLen,
                        MinSubstr = string:substr(S, StartIdx + 1, SubstrLen)
                end,
                Loop(Idx + 1, Char, 1, Idx);
            _ ->
                Loop(Idx + 1, Char, 1, Idx)
        end;
    _ -> 
        MinSubstr
    end,
    Loop(0, <<>>, 0, 0),
    MinSubstr.