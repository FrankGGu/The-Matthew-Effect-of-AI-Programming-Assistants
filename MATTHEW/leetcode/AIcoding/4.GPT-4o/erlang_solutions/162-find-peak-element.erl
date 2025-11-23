-spec find_peak_element(Nums :: [integer()]) -> integer().
find_peak_element([Head | Tail]) ->
    find_peak_element(Head, Tail, 0).

find_peak_element(_, [], Index) -> Index;
find_peak_element(Prev, [Curr | _], Index) when Prev > Curr -> Index;
find_peak_element(_, [Curr | Tail], Index) when Prev < Curr ->
    find_peak_element(Curr, Tail, Index + 1).
