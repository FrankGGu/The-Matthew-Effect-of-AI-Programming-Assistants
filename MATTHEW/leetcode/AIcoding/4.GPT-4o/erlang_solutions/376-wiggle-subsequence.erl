-spec wiggle_max_length(Nums :: [integer()]) -> integer().
wiggle_max_length([_]) -> 1;
wiggle_max_length([X, Y | Rest]) when X /= Y -> 
    wiggle_max_length([Y | Rest]) + 1;
wiggle_max_length([_ | Rest]) -> 
    wiggle_max_length(Rest);
wiggle_max_length([]) -> 0.
