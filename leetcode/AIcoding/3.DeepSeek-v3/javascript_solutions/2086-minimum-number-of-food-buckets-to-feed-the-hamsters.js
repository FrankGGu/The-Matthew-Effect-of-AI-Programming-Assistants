var minimumBuckets = function(hamsters) {
    const n = hamsters.length;
    let buckets = 0;
    for (let i = 0; i < n; i++) {
        if (hamsters[i] === 'H') {
            if (i > 0 && hamsters[i - 1] === 'B') {
                continue;
            }
            if (i < n - 1 && hamsters[i + 1] === '.') {
                hamsters = hamsters.substring(0, i + 1) + 'B' + hamsters.substring(i + 2);
                buckets++;
            } else if (i > 0 && hamsters[i - 1] === '.') {
                hamsters = hamsters.substring(0, i - 1) + 'B' + hamsters.substring(i);
                buckets++;
            } else {
                return -1;
            }
        }
    }
    return buckets;
};