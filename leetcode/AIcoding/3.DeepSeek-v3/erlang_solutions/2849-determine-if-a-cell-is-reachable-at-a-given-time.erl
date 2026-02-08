-spec is_reachable_at_time(Sx :: integer(), Sy :: integer(), Fx :: integer(), Fy :: integer(), T :: integer()) -> boolean().
is_reachable_at_time(Sx, Sy, Fx, Fy, T) ->
    XDist = abs(Fx - Sx),
    YDist = abs(Fy - Sy),
    MinDist = max(XDist, YDist),
    if
        MinDist == 0 andalso T == 1 -> false;
        true -> T >= MinDist
    end.