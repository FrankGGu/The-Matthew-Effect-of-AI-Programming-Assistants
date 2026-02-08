var poorPigs = function(buckets, minutesToDie, minutesToTest) {
    const rounds = minutesToTest / minutesToDie;
    const base = rounds + 1;

    let pigs = 0;
    let power = 1;

    while (power < buckets) {
        power *= base;
        pigs++;
    }

    return pigs;
};