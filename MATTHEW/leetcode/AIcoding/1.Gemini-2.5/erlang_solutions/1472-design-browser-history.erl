-module(browser_history).
-export([new/1, visit/2, back/2, forward/2]).

new(Homepage) ->
    #{urls => [Homepage], current_idx => 0, max_idx => 0}.

visit(State, Url) ->
    #{urls := Urls, current_idx := CurrentIdx} = State,
    TrimmedUrls = lists:take(CurrentIdx + 1, Urls),
    NewUrls = TrimmedUrls ++ [Url],
    NewCurrentIdx = CurrentIdx + 1,
    NewMaxIdx = NewCurrentIdx,
    #{urls => NewUrls, current_idx => NewCurrentIdx, max_idx => NewMaxIdx}.

back(State, Steps) ->
    #{urls := Urls, current_idx := CurrentIdx} = State,
    NewCurrentIdx = max(0, CurrentIdx - Steps),
    Url = lists:nth(NewCurrentIdx + 1, Urls),
    NewState = State#{} => #{current_idx => NewCurrentIdx},
    {Url, NewState}.

forward(State, Steps) ->
    #{urls := Urls, current_idx := CurrentIdx, max_idx := MaxIdx} = State,
    NewCurrentIdx = min(MaxIdx, CurrentIdx + Steps),
    Url = lists:nth(NewCurrentIdx + 1, Urls),
    NewState = State#{} => #{current_idx => NewCurrentIdx},
    {Url, NewState}.