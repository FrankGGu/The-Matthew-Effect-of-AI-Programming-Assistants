-module(tag_validator).
-export([is_valid/1]).

is_valid(Code) ->
  is_valid(string:tokens(Code, "<>"), []).

is_valid([], Stack) ->
  Stack == [];
is_valid([Token | Rest], Stack) ->
  case string:at(Token, 1) of
    "/" ->
      case Stack of
        [] ->
          false;
        [TopTag | Tail] ->
          ClosingTag = string:sub(Token, 2, string:length(Token) - 1),
          if
            TopTag == ClosingTag ->
              is_valid(Rest, Tail);
            true ->
              false
          end
      end;
    "!" ->
      case string:sub(Token, 2, 7) of
        "[CDATA[" ->
          is_valid(Rest, Stack);
        _ ->
          false
      end;
    _ ->
      case string:at(Token, string:length(Token)) of
        "/" ->
          false;
        _ ->
          case string:length(Token) of
            N when N >= 1 and N <= 9 ->
              case re:run(Token, "^[A-Z]+$") of
                {match, _} ->
                  is_valid(Rest, [Token | Stack]);
                nomatch ->
                  false
              end;
            _ ->
              false
          end
      end
  end.