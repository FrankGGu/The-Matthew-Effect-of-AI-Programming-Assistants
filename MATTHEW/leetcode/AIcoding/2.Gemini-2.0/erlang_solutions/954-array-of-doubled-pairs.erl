-module(array_of_doubled_pairs).
-export([canReorderDoubled/1]).

canReorderDoubled(Arr) ->
  canReorderDoubled(Arr, []).

canReorderDoubled([], _Pairs) ->
  true;
canReorderDoubled([H | T], Pairs) ->
  case lists:member({H, H * 2}, Pairs) of
    true ->
      canReorderDoubled(T, lists:delete({H, H * 2}, Pairs));
    false ->
      case lists:member({H * 2, H}, Pairs) of
        true ->
          canReorderDoubled(T, lists:delete({H * 2, H}, Pairs));
        false ->
          case lists:member(H * 2, T) of
            true ->
              NewT = lists:delete(H * 2, T),
              canReorderDoubled(NewT, Pairs);
            false ->
              case H rem 2 == 0 andalso lists:member(H div 2, T) of
                true ->
                  NewT = lists:delete(H div 2, T),
                  canReorderDoubled(NewT, Pairs);
                false ->
                  false
              end
          end
      end
  end.