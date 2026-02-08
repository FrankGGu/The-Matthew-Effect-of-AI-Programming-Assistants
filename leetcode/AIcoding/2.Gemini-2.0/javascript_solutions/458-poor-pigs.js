var poorPigs = function(buckets, minutesToDie, minutesToTest) {
    if (buckets === 1) return 0;
    let pigs = 0;
    let states = Math.floor(minutesToTest / minutesToDie) + 1;
    while (Math.pow(states, pigs) < buckets) {
        pigs++;
    }
    return pigs;
};