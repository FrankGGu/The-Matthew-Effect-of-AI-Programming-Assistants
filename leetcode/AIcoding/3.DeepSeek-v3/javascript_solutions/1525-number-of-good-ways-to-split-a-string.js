var numSplits = function(s) {
    const leftCount = new Map();
    const rightCount = new Map();
    let goodSplits = 0;

    for (const char of s) {
        rightCount.set(char, (rightCount.get(char) || 0) + 1);
    }

    for (const char of s) {
        leftCount.set(char, (leftCount.get(char) || 0) + 1);
        rightCount.set(char, rightCount.get(char) - 1);

        if (rightCount.get(char) === 0) {
            rightCount.delete(char);
        }

        if (leftCount.size === rightCount.size) {
            goodSplits++;
        }
    }

    return goodSplits;
};