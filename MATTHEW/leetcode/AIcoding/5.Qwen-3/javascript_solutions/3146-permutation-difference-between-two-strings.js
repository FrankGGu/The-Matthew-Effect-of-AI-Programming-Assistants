function permutationDifference(s, t) {
    const indexMap = new Map();
    for (let i = 0; i < s.length; i++) {
        indexMap.set(s[i], i);
    }
    let diff = 0;
    for (let i = 0; i < t.length; i++) {
        diff += Math.abs(indexMap.get(t[i]) - i);
    }
    return diff;
}