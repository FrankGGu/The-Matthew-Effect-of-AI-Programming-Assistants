-module(remove_subfolders).
-export([remove_subfolders/1]).

remove_subfolders(Folder) ->
  Sorted = lists:sort(Folder),
  remove_subfolders_helper(Sorted, []).

remove_subfolders_helper([], Acc) ->
  lists:reverse(Acc);
remove_subfolders_helper([H | T], Acc) ->
  case Acc of
    [] ->
      remove_subfolders_helper(T, [H]);
    [Last | _] ->
      case string:starts_with(H, Last ++ "/") of
        true ->
          remove_subfolders_helper(T, Acc);
        false ->
          remove_subfolders_helper(T, [H | Acc])
      end
  end.