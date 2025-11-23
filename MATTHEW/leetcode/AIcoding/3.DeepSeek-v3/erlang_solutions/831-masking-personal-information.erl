-spec mask_pii(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
mask_pii(S) ->
    case is_email(S) of
        true -> mask_email(S);
        false -> mask_phone(S)
    end.

is_email(S) ->
    case re:run(S, "@", [unicode]) of
        nomatch -> false;
        _ -> true
    end.

mask_email(S) ->
    [First, Rest] = binary:split(S, <<"@">>),
    [Domain, Tld] = binary:split(Rest, <<".">>),
    MaskedFirst = <<(binary:part(First, 0, 1))/binary, "*****", (binary:part(First, byte_size(First) - 1, 1))/binary>>,
    <<MaskedFirst/binary, "@", Domain/binary, ".", Tld/binary>>.

mask_phone(S) ->
    Cleaned = re:replace(S, "[^0-9]", "", [global, {return, binary}]),
    Len = byte_size(Cleaned),
    LastFour = binary:part(Cleaned, Len - 4, 4),
    case Len of
        10 -> <<"***-***-", LastFour/binary>>;
        11 -> <<"+*-***-***-", LastFour/binary>>;
        12 -> <<"+**-***-***-", LastFour/binary>>;
        13 -> <<"+***-***-***-", LastFour/binary>>;
        _ -> <<"">>
    end.