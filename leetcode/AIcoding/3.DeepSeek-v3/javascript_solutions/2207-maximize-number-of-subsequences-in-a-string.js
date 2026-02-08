var maximumSubsequenceCount = function(text, pattern) {
    const [a, b] = pattern.split('');
    let countA = 0, countB = 0, res = 0;

    for (const c of text) {
        if (c === b) {
            res += countA;
            countB++;
        }
        if (c === a) {
            countA++;
        }
    }

    return res + Math.max(countA, countB);
};