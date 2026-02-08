var findLongestChain = function(pairs) {
    pairs.sort((a, b) => a[1] - b[1]);
    let currentEnd = -Infinity;
    let count = 0;
    for (let pair of pairs) {
        if (pair[0] > currentEnd) {
            count++;
            currentEnd = pair[1];
        }
    }
    return count;
};