var findLongestChain = function(pairs) {
    pairs.sort((a, b) => a[1] - b[1]);
    let count = 0, end = -Infinity;
    for (const [start, finish] of pairs) {
        if (start > end) {
            count++;
            end = finish;
        }
    }
    return count;
};