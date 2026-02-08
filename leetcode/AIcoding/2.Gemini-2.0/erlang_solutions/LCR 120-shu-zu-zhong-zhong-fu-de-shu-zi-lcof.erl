-module(find_duplicate).
-export([find_duplicate/1]).

find_duplicate(Paths) ->
  lists:foldl(
    fun(Path, Acc) ->
      [Dir | Files] = string:tokens(Path, " "),
      lists:foldl(
        fun(File, Acc2) ->
          {Filename, Content} = parse_file(File),
          case maps:is_key(Content, Acc2) of
            true ->
              maps:update_with(Content, fun(List) -> [Dir ++ "/" ++ Filename | List] end, [Dir ++ "/" ++ Filename], Acc2);
            false ->
              maps:put(Content, [Dir ++ "/" ++ Filename], Acc2)
          end
        end,
        Acc,
        Files
      )
    end,
    #{},
    Paths
  )
  |> maps:values()
  |> lists:filter(fun(List) -> length(List) > 1 end).

parse_file(File) ->
  {Filename, Rest} = string:split(File, "("),
  {Content, _} = string:split(Rest, ")"),
  {Filename, Content}.