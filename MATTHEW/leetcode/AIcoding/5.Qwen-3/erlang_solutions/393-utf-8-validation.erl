-module(utf8_validation).
-export([valid_utf8/1]).

valid_utf8(Bits) ->
    valid_utf8(Bits, 0).

valid_utf8([], _) ->
    true;
valid_utf8([Byte | Rest], Count) when Count > 0 ->
    case (Byte band 192) of
        128 -> valid_utf8(Rest, Count - 1);
        _ -> false
    end;
valid_utf8([Byte | Rest], 0) ->
    case (Byte band 255) of
        255 -> valid_utf8(Rest, 3);
        254 -> valid_utf8(Rest, 2);
        253 -> valid_utf8(Rest, 2);
        252 -> valid_utf8(Rest, 2);
        251 -> valid_utf8(Rest, 2);
        250 -> valid_utf8(Rest, 2);
        249 -> valid_utf8(Rest, 2);
        248 -> valid_utf8(Rest, 2);
        247 -> valid_utf8(Rest, 2);
        246 -> valid_utf8(Rest, 2);
        245 -> valid_utf8(Rest, 2);
        244 -> valid_utf8(Rest, 2);
        243 -> valid_utf8(Rest, 2);
        242 -> valid_utf8(Rest, 2);
        241 -> valid_utf8(Rest, 2);
        240 -> valid_utf8(Rest, 2);
        239 -> valid_utf8(Rest, 2);
        238 -> valid_utf8(Rest, 2);
        237 -> valid_utf8(Rest, 2);
        236 -> valid_utf8(Rest, 2);
        235 -> valid_utf8(Rest, 2);
        234 -> valid_utf8(Rest, 2);
        233 -> valid_utf8(Rest, 2);
        232 -> valid_utf8(Rest, 2);
        231 -> valid_utf8(Rest, 2);
        230 -> valid_utf8(Rest, 2);
        229 -> valid_utf8(Rest, 2);
        228 -> valid_utf8(Rest, 2);
        227 -> valid_utf8(Rest, 2);
        226 -> valid_utf8(Rest, 2);
        225 -> valid_utf8(Rest, 2);
        224 -> valid_utf8(Rest, 2);
        223 -> valid_utf8(Rest, 1);
        222 -> valid_utf8(Rest, 1);
        221 -> valid_utf8(Rest, 1);
        220 -> valid_utf8(Rest, 1);
        219 -> valid_utf8(Rest, 1);
        218 -> valid_utf8(Rest, 1);
        217 -> valid_utf8(Rest, 1);
        216 -> valid_utf8(Rest, 1);
        215 -> valid_utf8(Rest, 1);
        214 -> valid_utf8(Rest, 1);
        213 -> valid_utf8(Rest, 1);
        212 -> valid_utf8(Rest, 1);
        211 -> valid_utf8(Rest, 1);
        210 -> valid_utf8(Rest, 1);
        209 -> valid_utf8(Rest, 1);
        208 -> valid_utf8(Rest, 1);
        207 -> valid_utf8(Rest, 1);
        206 -> valid_utf8(Rest, 1);
        205 -> valid_utf8(Rest, 1);
        204 -> valid_utf8(Rest, 1);
        203 -> valid_utf8(Rest, 1);
        202 -> valid_utf8(Rest, 1);
        201 -> valid_utf8(Rest, 1);
        200 -> valid_utf8(Rest, 1);
        199 -> valid_utf8(Rest, 1);
        198 -> valid_utf8(Rest, 1);
        197 -> valid_utf8(Rest, 1);
        196 -> valid_utf8(Rest, 1);
        195 -> valid_utf8(Rest, 1);
        194 -> valid_utf8(Rest, 1);
        193 -> valid_utf8(Rest, 1);
        192 -> valid_utf8(Rest, 1);
        191 -> valid_utf8(Rest, 0);
        _ -> false
    end.