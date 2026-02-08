-module(remove_comments).
-export([remove_comments/1]).

remove_comments(Source) ->
  remove_comments(Source, []).

remove_comments([], Acc) ->
  lists:reverse(Acc);
remove_comments(Source, Acc) ->
  case string:str(Source, "//") of
    0 ->
      case string:str(Source, "/*") of
        0 ->
          remove_comments([], [Source | Acc]);
        Pos ->
          {Before, Rest} = lists:split(Pos - 1, Source),
          case string:str(Rest, "*/") of
            0 ->
              remove_comments([], [Before | Acc]);
            EndPos ->
              {_, After} = lists:split(EndPos + 1, Rest),
              remove_comments(lists:sublist(After, length(After)), [Before | Acc])
          end
      end;
    Pos ->
      {Before, Rest} = lists:split(Pos - 1, Source),
      remove_comments(string:trim(lists:nth(2, string:split(Rest, "\n"))), [Before | Acc])
  end.

remove_comments(Source) ->
  Source_str = string:join(Source, "\n"),
  Result = remove_comments(Source_str, []),
  lists:filter(fun(Line) -> length(string:trim(Line)) > 0 end, string:split(Result, "\n")).