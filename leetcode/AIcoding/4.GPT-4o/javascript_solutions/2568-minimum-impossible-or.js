var findMinimumImpossibleOR = function(A) {
    let impossible = 1;
    const seen = new Set(A);

    while (seen.has(impossible)) {
        impossible++;
    }

    return impossible;
};