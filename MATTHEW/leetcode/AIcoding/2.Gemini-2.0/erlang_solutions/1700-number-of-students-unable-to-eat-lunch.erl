-module(lunch).
-export([count_students/2]).

count_students(Students, Sandwiches) ->
  count_students(Students, Sandwiches, 0).

count_students(Students, Sandwiches, Count) ->
  case Students of
    [] ->
      Count;
    _ ->
      case Sandwiches of
        [] ->
          length(Students);
        _ ->
          case lists:nth(1, Students) of
            lists:nth(1, Sandwiches) ->
              count_students(lists:sublist(Students, 2, length(Students) - 1),
                             lists:sublist(Sandwiches, 2, length(Sandwiches) - 1),
                             Count);
            _ ->
              case Students =:= rotate_students(Students) of
                true ->
                  length(Students);
                false ->
                  count_students(rotate_students(Students), Sandwiches, Count)
              end
          end
      end
  end.

rotate_students(Students) ->
  case Students of
    [] ->
      [];
    [H|T] ->
      T ++ [H]
  end.