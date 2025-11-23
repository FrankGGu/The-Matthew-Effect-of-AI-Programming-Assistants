var findLongestChain = function(pairs) {
    if (pairs.length === 0) {
        return 0;
    }

    pairs.sort((a, b) => a[1] - b[1]);

    let chainLength = 1;
    let currentEnd = pairs[0][1];

    for (let i = 1; i < pairs.length; i++) {
        if (pairs[i][0] > currentEnd) {
            chainLength++;
            currentEnd = pairs[i][1];
        }
    }

    return chainLength;
};