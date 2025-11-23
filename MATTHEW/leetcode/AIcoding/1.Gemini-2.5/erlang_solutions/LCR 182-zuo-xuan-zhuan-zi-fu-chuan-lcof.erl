-module(solution).
-export([dynamic_password/2]).

dynamic_password(Secret, Counter) ->
    SecretBin = case Secret of
                    B when is_binary(B) -> B;
                    S when is_list(S) -> list_to_binary(S)
                end,
    CounterBin = <<Counter:64/big-unsigned-integer>>,
    HMAC = crypto:hmac(sha, SecretBin, CounterBin),
    Offset = binary:at(HMAC, byte_size(HMAC) - 1) band 0x0F,
    <<_:((Offset)*8)/integer, SBits:32/big-unsigned-integer, _/binary>> = HMAC,
    DynamicCode = SBits band 0x7FFFFFFF,
    OTP = DynamicCode rem 1000000,
    io_lib:format("~.6.0B", [OTP]).