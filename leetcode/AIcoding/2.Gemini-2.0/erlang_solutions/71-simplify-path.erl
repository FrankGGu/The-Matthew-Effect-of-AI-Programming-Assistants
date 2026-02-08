-module(simplify_path).
-export([simplify_path/1]).

simplify_path(Path) ->
  PathList = string:split(Path, "/", all),
  SimplifiedPathList = simplify(PathList, []),
  "/" ++ string:join(SimplifiedPathList, "/").

simplify([], Acc) ->
  lists:reverse(Acc);
simplify(["."|Rest], Acc) ->
  simplify(Rest, Acc);
simplify([".."|Rest], [_|Acc]) ->
  simplify(Rest, Acc);
simplify([".."|Rest], []) ->
  simplify(Rest, []);
simplify([""|Rest], Acc) ->
  simplify(Rest, Acc);
simplify([Dir|Rest], Acc) ->
  simplify(Rest, [Dir|Acc]).