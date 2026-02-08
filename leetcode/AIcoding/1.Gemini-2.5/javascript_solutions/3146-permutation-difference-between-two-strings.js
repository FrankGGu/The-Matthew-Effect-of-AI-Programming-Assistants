var findPermutationDifference = function(s, t) {
    const tCharIndices = new Map();
    for (let i = 0; i < t.length; i++) {
        tCharIndices.set(t[i], i);
    }

    let totalDifference = 0;
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        const indexInS = i;
        const indexInT = tCharIndices.get(char);
        totalDifference += Math.abs(indexInS - indexInT);
    }

    return totalDifference;
};