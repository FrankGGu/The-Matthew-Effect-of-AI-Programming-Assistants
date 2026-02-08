-spec majority_element(Nums :: [integer()]) -> integer().
majority_element([Head | Tail]) ->
    majority_element(Tail, Head, 1);
majority_element([], Majority, _) ->
    Majority;
majority_element([Head | Tail], Majority, Count) when Head == Majority ->
    majority_element(Tail, Majority, Count + 1);
majority_element([Head | Tail], Majority, Count) when Head /= Majority ->
    majority_element(Tail, Majority, Count - 1);
