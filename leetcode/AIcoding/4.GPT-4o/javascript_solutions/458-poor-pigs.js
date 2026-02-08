var poorPigs = function(buckets, minutesToDie, minutesToTest) {
    const tests = Math.floor(minutesToTest / minutesToDie);
    return Math.ceil(Math.log(buckets) / Math.log(tests + 1));
};