-module(categorize_box).
-export([categorize_box/4]).

categorize_box(Length, Width, Height, Mass) ->
  Volume = Length * Width * Height,
  Bulky = (Length >= 10000 or Width >= 10000 or Height >= 10000 or Volume >= 1000000000),
  Heavy = (Mass >= 100),
  case {Bulky, Heavy} of
    {true, true} -> "Both";
    {true, false} -> "Bulky";
    {false, true} -> "Heavy";
    {false, false} -> "Neither"
  end.