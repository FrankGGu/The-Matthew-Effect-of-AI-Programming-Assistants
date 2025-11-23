-spec is_ugly(N :: integer()) -> boolean().
is_ugly(N) when N <= 0 -> false;
is_ugly(1) -> true;
is_ugly(N) ->
    case N rem 2 of
        0 -> is_ugly(N div 2);
        _ -> case N rem 3 of
                0 -> is_ugly(N div 3);
                _ -> case N rem 5 of
                        0 -> is_ugly(N div 5);
                        _ -> false
              end
    end.
