-module(solution).
-export([compareVersion/2]).

compareVersion(Version1, Version2) ->
    ParsedV1 = parse_version(Version1),
    ParsedV2 = parse_version(Version2),
    compare_parsed_versions(ParsedV1, ParsedV2).

parse_version(VersionString) ->
    Tokens = string:tokens(VersionString, "."),
    lists:map(fun list_to_integer/1, Tokens).

compare_parsed_versions([], []) ->
    0;
compare_parsed_versions([H1|T1], []) ->
    case lists:any(fun(X) -> X > 0 end, [H1|T1]) of
        true -> 1;
        false -> 0
    end;
compare_parsed_versions([], [H2|T2]) ->
    case lists:any(fun(X) -> X > 0 end, [H2|T2]) of
        true -> -1;
        false -> 0
    end;
compare_parsed_versions([H1|T1], [H2|T2]) ->
    if
        H1 > H2 -> 1;
        H1 < H2 -> -1;
        true -> compare_parsed_versions(T1, T2)
    end.