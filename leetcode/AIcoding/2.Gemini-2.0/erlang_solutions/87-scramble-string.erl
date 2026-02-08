-module(scramble_string).
-export([is_scramble/2]).

is_scramble(S1, S2) ->
  is_scramble(S1, S2, []).

is_scramble(S1, S2, Cache) ->
  case lists:member({S1, S2}, Cache) of
    true ->
      true;
    false ->
      case (length(S1) /= length(S2)) of
        true ->
          false;
        false ->
          case (S1 == S2) of
            true ->
              true;
            false ->
              case (lists:sort(string:to_list(S1)) /= lists:sort(string:to_list(S2))) of
                true ->
                  false;
                false ->
                  N = length(S1),
                  is_scramble_helper(S1, S2, 1, N, Cache)
              end
          end
      end
  end.

is_scramble_helper(S1, S2, I, N, Cache) ->
  case (I > N - 1) of
    true ->
      false;
    false ->
      S1Left = string:sub(S1, 1, I),
      S1Right = string:sub(S1, I + 1, N - I),
      S2Left = string:sub(S2, 1, I),
      S2Right = string:sub(S2, I + 1, N - I),
      S2LeftRev = string:sub(S2, N - I + 1, I),
      S2RightRev = string:sub(S2, 1, N - I),
      case (is_scramble(S1Left, S2Left, Cache) andalso is_scramble(S1Right, S2Right, Cache)) of
        true ->
          true;
        false ->
          case (is_scramble(S1Left, S2LeftRev, Cache) andalso is_scramble(S1Right, S2RightRev, Cache)) of
            true ->
              true;
            false ->
              is_scramble_helper(S1, S2, I + 1, N, Cache)
          end
      end
  end.