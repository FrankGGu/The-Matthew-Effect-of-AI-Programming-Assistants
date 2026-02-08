-module(compare_version).
-export([compare_version/2]).

compare_version(Version1, Version2) ->
  compare(parse_version(Version1), parse_version(Version2)).

parse_version(Version) ->
  string:tokens(Version, ".").

compare([], []) -> 0;
compare([], _) -> -1;
compare(_, []) -> 1;
compare([H1|T1], [H2|T2]) ->
  I1 = list_to_integer(H1),
  I2 = list_to_integer(H2),
  case I1 > I2 of
    true -> 1;
    false ->
      case I1 < I2 of
        true -> -1;
        false -> compare(T1, T2)
      end
  end.