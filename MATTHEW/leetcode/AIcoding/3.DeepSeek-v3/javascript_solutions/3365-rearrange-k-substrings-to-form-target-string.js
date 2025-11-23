var rearrangeCharacters = function(s, target) {
    const countS = {};
    const countT = {};

    for (const char of s) {
        countS[char] = (countS[char] || 0) + 1;
    }

    for (const char of target) {
        countT[char] = (countT[char] || 0) + 1;
    }

    let minCopies = Infinity;

    for (const char in countT) {
        if (!countS[char]) {
            return 0;
        }
        const copies = Math.floor(countS[char] / countT[char]);
        if (copies < minCopies) {
            minCopies = copies;
        }
    }

    return minCopies;
};