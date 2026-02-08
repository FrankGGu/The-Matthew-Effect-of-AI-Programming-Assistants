-module(count_and_say).
-export([count_and_say/1]).

count_and_say(1) ->
    "1";
count_and_say(N) ->
    count_and_say_helper("1", N - 1).

count_and_say_helper(S, 0) ->
    S;
count_and_say_helper(S, N) ->
    Next = generate_next(S),
    count_and_say_helper(Next, N - 1).

generate_next(S) ->
    generate_next_helper(S, []).

generate_next_helper([], Acc) ->
    lists:reverse(Acc);
generate_next_helper([H | T], Acc) ->
    {Count, Rest} = count_same([H | T], H, 0),
    generate_next_helper(Rest, [integer_to_list(Count), H | Acc]).

count_same([], _, Count) ->
    {Count, []};
count_same([H | T], Val, Count) ->
    if
        H == Val ->
            count_same(T, Val, Count + 1);
        true ->
            {Count, [H | T]}
    end.