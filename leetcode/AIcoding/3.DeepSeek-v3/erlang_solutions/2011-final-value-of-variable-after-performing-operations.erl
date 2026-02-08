-spec final_value_after_operations(Operations :: [unicode:unicode_binary()]) -> integer().
final_value_after_operations(Operations) ->
    lists:foldl(fun(Op, Acc) ->
        case Op of
            <<"++X">> -> Acc + 1;
            <<"X++">> -> Acc + 1;
            <<"--X">> -> Acc - 1;
            <<"X--">> -> Acc - 1
        end
    end, 0, Operations).