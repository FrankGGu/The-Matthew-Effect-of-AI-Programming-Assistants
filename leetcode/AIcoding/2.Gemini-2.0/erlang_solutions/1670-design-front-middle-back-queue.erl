-module(front_middle_back_queue).
-export([new/0, pushFront/2, pushMiddle/2, pushBack/2, popFront/1, popMiddle/1, popBack/1, size/1]).

new() -> {[], []}.

pushFront({Front, Back}, Val) -> {[Val | Front], Back}.

pushMiddle({Front, Back}, Val) ->
    Size = length(Front) + length(Back),
    Middle = Size div 2,
    {NewFront, NewBack} = split(Front ++ Back, Middle, [], []),
    {[Val | NewFront], NewBack};

split([], _, FrontAcc, BackAcc) -> {lists:reverse(FrontAcc), lists:reverse(BackAcc)};
split(List, 0, FrontAcc, BackAcc) -> {lists:reverse(FrontAcc), lists:reverse(List)};
split([H | T], N, FrontAcc, BackAcc) -> split(T, N - 1, [H | FrontAcc], BackAcc).

pushBack({Front, Back}, Val) -> {Front, [Val | Back]}.

popFront({[], []}) -> -1;
popFront({[H | T], Back}) -> {H, {T, Back}};
popFront({[], Back}) ->
    NewBack = lists:reverse(Back),
    case NewBack of
        [] -> -1;
        [H | Tail] -> {H, {[], lists:reverse(Tail)}}
    end.

popMiddle({[], []}) -> -1;
popMiddle({Front, Back}) ->
    Size = length(Front) + length(Back),
    Middle = (Size - 1) div 2,
    {NewFront, NewBack} = split(Front ++ Back, Middle, [], []),
    case NewFront of
        [] ->
            NewBackRev = lists:reverse(NewBack),
            case NewBackRev of
                [] -> -1;
                [H | T] -> {H, {[], lists:reverse(T)}}
            end;
        [H | T] -> {H, {T, NewBack}}
    end.

popBack({[], []}) -> -1;
popBack({Front, [H | T]}) -> {H, {Front, T}};
popBack({Front, []}) ->
    NewFront = lists:reverse(Front),
    case NewFront of
        [] -> -1;
        [H | Tail] -> {H, {lists:reverse(Tail), []}}
    end.

size({Front, Back}) -> length(Front) + length(Back).