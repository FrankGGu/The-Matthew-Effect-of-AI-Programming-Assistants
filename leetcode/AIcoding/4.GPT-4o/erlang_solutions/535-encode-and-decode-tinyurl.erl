-module(solution).
-export([encode/1, decode/1]).

%% Global map to store the mapping between short and long URLs.
-define(URL_MAP, %{}).

%% Encodes a URL to a shortened URL.
-spec encode(string()) -> string().
encode(LongUrl) ->
    %% Generate a random short key.
    ShortKey = random:uniform(1000000),
    ShortUrl = "http://tinyurl.com/" ++ integer_to_list(ShortKey),
    
    %% Store the mapping in the URL_MAP
    ?URL_MAP:put(ShortUrl, LongUrl, ?URL_MAP),
    
    ShortUrl.

%% Decodes a shortened URL to its original URL.
-spec decode(string()) -> string().
decode(ShortUrl) ->
    %% Retrieve the original long URL from the map.
    case ?URL_MAP:get(ShortUrl, ?URL_MAP) of
        undefined -> "";
        LongUrl -> LongUrl
    end.
