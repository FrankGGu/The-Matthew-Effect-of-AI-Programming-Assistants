-module(long_pressed_name).
-export([isLongPressedName/2]).

isLongPressedName(Name, Typed) ->
  isLongPressedName(Name, Typed, 1, 1).

isLongPressedName(Name, Typed, N, T) ->
  NameLen = length(Name),
  TypedLen = length(Typed),
  if
    N > NameLen and T > TypedLen ->
      true;
    N > NameLen ->
      false;
    T > TypedLen ->
      false;
    true ->
      NameChar = lists:nth(N, Name),
      TypedChar = lists:nth(T, Typed),
      if
        NameChar == TypedChar ->
          isLongPressedName(Name, Typed, N + 1, T + 1);
        true ->
          if
            T > 1 ->
              PrevTypedChar = lists:nth(T - 1, Typed),
              if
                PrevTypedChar == TypedChar ->
                  isLongPressedName(Name, Typed, N, T + 1);
                true ->
                  false
              end;
            true ->
              false
          end
      end
  end.