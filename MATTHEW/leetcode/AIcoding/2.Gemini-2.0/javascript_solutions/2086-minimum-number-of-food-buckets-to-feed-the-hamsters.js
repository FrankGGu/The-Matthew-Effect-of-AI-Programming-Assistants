var minimumBuckets = function(hamsters) {
    let n = hamsters.length;
    let buckets = 0;
    let i = 0;
    while (i < n) {
        if (hamsters[i] === 'H') {
            if (i > 0 && hamsters[i - 1] === 'B') {
                i++;
                continue;
            }
            if (i < n - 1 && hamsters[i + 1] === '.') {
                buckets++;
                i += 2;
            } else if (i > 0 && hamsters[i - 1] === '.') {
                buckets++;
                i++;
            } else {
                return -1;
            }
        } else {
            i++;
        }
    }
    return buckets;
};