-module(solution).
-export([entityParser/1]).

entityParser(Html) ->
    Html1 = string:replace(Html, "&quot;", "\"", all),
    Html2 = string:replace(Html1, "&apos;", "'", all),
    Html3 = string:replace(Html2, "&amp;", "&", all),
    Html4 = string:replace(Html3, "&gt;", ">", all),
    string:replace(Html4, "&lt;", "<", all).