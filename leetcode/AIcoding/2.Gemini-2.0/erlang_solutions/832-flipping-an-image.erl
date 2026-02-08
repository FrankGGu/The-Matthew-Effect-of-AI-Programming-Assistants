-module(flipping_image).
-export([flip_and_invert_image/1]).

flip_and_invert_image(Image) ->
    [lists:reverse([invert(Pixel) || Pixel <- Row]) || Row <- Image].

invert(0) -> 1;
invert(1) -> 0.