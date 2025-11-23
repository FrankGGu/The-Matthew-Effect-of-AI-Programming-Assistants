var findPermutationDifference = function(s, t) {
    const indexMap = {};
    for (let i = 0; i < s.length; i++) {
        indexMap[s[i]] = i;
    }
    let difference = 0;
    for (let j = 0; j < t.length; j++) {
        difference += Math.abs(j - indexMap[t[j]]);
    }
    return difference;
};