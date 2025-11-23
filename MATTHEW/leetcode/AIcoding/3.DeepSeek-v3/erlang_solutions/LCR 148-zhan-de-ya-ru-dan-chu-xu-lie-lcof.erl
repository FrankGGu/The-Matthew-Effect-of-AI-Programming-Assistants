-spec validate_book_sequences(put_in :: [integer()], take_out :: [integer()]) -> boolean().
validate_book_sequences(PutIn, TakeOut) ->
    Stack = [],
    validate(PutIn, TakeOut, Stack).

validate([], [], _) -> true;
validate(PutIn, [H | TakeOut], Stack) ->
    case Stack of
        [H | RestStack] -> validate(PutIn, TakeOut, RestStack);
        _ ->
            case PutIn of
                [] -> false;
                [X | RestPutIn] -> validate(RestPutIn, [H | TakeOut], [X | Stack])
            end
    end.