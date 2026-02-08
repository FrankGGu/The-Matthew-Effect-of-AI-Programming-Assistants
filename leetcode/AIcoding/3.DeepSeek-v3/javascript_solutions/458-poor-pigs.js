var poorPigs = function(buckets, minutesToDie, minutesToTest) {
    let tests = Math.floor(minutesToTest / minutesToDie) + 1;
    let pigs = 0;
    while (Math.pow(tests, pigs) < buckets) {
        pigs++;
    }
    return pigs;
};