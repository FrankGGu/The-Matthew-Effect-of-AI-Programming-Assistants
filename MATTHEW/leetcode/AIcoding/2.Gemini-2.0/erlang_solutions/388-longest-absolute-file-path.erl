-module(longest_absolute_file_path).
-export([lengthLongestPath/1]).

lengthLongestPath(Input) ->
  lengthLongestPathHelper(string:split(Input, "\n", all), [], 0).

lengthLongestPathHelper([], _Stack, MaxLen) ->
  MaxLen;
lengthLongestPathHelper([Path | Rest], Stack, MaxLen) ->
  {Depth, Name} = parsePath(Path, 0),
  NewStack = updateStack(Stack, Depth, Name),
  NewMaxLen = calculateMaxLen(NewStack, MaxLen),
  lengthLongestPathHelper(Rest, NewStack, NewMaxLen).

parsePath(Path, Depth) ->
  case string:prefix(Path, "\t") of
    true ->
      parsePath(string:substr(Path, 2), Depth + 1);
    false ->
      {Depth, Path}
  end.

updateStack(Stack, Depth, Name) ->
  case Stack of
    [] ->
      [{Depth, Name}];
    _ ->
      case Depth < length(Stack) of
        true ->
          lists:sublist(Stack, 1, Depth) ++ [{Depth, Name}];
        false ->
          Stack ++ [{Depth, Name}]
      end
  end.

calculateMaxLen(Stack, MaxLen) ->
  case lists:last(Stack) of
    {_Depth, Name} when string:rstr(Name, ".") > 0 ->
      PathLen = lists:sum([string:length(N) || {_D, N} <- Stack]) + length(Stack) - 1,
      max(MaxLen, PathLen);
    _ ->
      MaxLen
  end.