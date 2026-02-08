-module(longest_increasing_subsequence).
-export([length_of_lis/1]).

length_of_lis(Nums) ->
    length_of_lis_helper(Nums, []).

length_of_lis_helper([], Acc) ->
    length(Acc);
length_of_lis_helper([H|T], Acc) ->
    length_of_lis_helper(T, update_tails(H, Acc)).

update_tails(H, []) ->
    [H];
update_tails(H, [Tail|Tails]) ->
    case H > Tail of
        true ->
            [Tail|update_tails(H, Tails)];
        false ->
            case Tails of
                [] ->
                    [H];
                _ ->
                    [H|Tails]
            end
    end.