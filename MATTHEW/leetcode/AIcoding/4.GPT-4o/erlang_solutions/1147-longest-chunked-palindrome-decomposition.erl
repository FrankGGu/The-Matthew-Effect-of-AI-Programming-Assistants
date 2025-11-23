-module(solution).
-export([longest_decomposition/1]).

longest_decomposition(S) ->
    longest_decomposition(S, 0).

longest_decomposition(S, Count) when S == "" ->
    Count;
longest_decomposition(S, Count) ->
    {Prefix, Suffix} = prefix_suffix(S),
    case Prefix of
        "" -> Count;
        _ -> longest_decomposition(Suffix, Count + 1)
    end.

prefix_suffix(S) ->
    {Prefix, Suffix} = prefix_suffix_helper(S, 1, length(S)),
    {Prefix, string:substr(S, length(Prefix) + 1)}.

prefix_suffix_helper(S, Start, Length) when Start < Length ->
    Prefix = string:substr(S, 1, Start),
    if
        Prefix == string:substr(S, Length - Start + 1, Start) ->
            {Prefix, Start};
        true ->
            prefix_suffix_helper(S, Start + 1, Length)
    end;
prefix_suffix_helper(_, _, _) ->
    {"", 0}.