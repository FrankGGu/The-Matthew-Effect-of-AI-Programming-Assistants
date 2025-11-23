function numberOfTimesBinaryStringIsPrefixAligned(n, flips) {
    let count = 0;
    let max = 0;
    for (let i = 0; i < flips.length; i++) {
        max = Math.max(max, flips[i]);
        if (max === i + 1) {
            count++;
        }
    }
    return count;
}