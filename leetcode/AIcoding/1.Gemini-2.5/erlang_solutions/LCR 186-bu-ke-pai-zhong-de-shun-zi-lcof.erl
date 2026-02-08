-module(solution).
-export([solve/1]).

solve(Years) ->
    [classify_year(Year) || Year <- Years].

classify_year(Year) when Year >= 0, Year < 100 -> xia;
classify_year(Year) when Year >= 100, Year < 200 -> shang;
classify_year(Year) when Year >= 200, Year < 300 -> zhou;
classify_year(Year) when Year >= 300, Year < 400 -> qin;
classify_year(Year) when Year >= 400, Year < 500 -> han;
classify_year(Year) when Year >= 500, Year < 600 -> tang;
classify_year(Year) when Year >= 600, Year < 700 -> song;
classify_year(Year) when Year >= 700, Year < 800 -> ming;
classify_year(Year) when Year >= 800, Year < 900 -> qing;
classify_year(Year) when Year >= 900 -> modern;
classify_year(_) -> unknown.