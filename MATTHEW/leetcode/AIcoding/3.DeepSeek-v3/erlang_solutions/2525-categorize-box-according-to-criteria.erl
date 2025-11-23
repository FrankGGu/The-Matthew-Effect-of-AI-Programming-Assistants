-spec categorize_box(Length :: integer(), Width :: integer(), Height :: integer(), Mass :: integer()) -> unicode:unicode_binary().
categorize_box(Length, Width, Height, Mass) ->
    Bulky = (Length >= 10000 orelse Width >= 10000 orelse Height >= 10000) orelse
            (Length * Width * Height >= 1000000000),
    Heavy = Mass >= 100,
    case {Bulky, Heavy} of
        {true, true} -> <<"Both">>;
        {true, false} -> <<"Bulky">>;
        {false, true} -> <<"Heavy">>;
        {false, false} -> <<"Neither">>
    end.