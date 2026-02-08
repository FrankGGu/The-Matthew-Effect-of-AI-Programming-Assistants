-module(find_duplicate).
-export([find_duplicate/1]).

find_duplicate(paths) ->
  ContentMap = lists:foldl(
    fun(Path, Acc) ->
      Words = string:split(Path, " ", all),
      Dir = lists:nth(0, Words),
      lists:foldl(
        fun(File, InnerAcc) ->
          case string:find(File, "(", leading) of
            nomatch -> InnerAcc;
            Index ->
              Filename = string:sub(File, 1, Index - 1),
              Content = string:sub(File, Index + 1, string:len(File) - Index - 2),
              FullFilename = Dir ++ "/" ++ Filename,
              case maps:is_key(Content, InnerAcc) of
                true ->
                  maps:update(Content, [FullFilename | maps:get(Content, InnerAcc)], InnerAcc);
                false ->
                  maps:put(Content, [FullFilename], InnerAcc)
              end
          end
        end,
        Acc,
        lists:sublist(Words, 2, length(Words) - 1)
      )
    end,
    #{},
    paths
  ),
  lists:filter(
    fun(_, Values) -> length(Values) > 1 end,
    maps:to_list(ContentMap)
  )
  |> lists:map(fun({_, Values}) -> Values end).