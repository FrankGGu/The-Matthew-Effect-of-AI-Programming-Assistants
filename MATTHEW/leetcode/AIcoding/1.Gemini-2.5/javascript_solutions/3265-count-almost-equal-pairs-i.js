var countAlmostEqualPairs = function(s1, s2) {
    let count = 0;
    const n = s1.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (s1[i] === s2[j] && s1[j] === s2[i]) {
                count++;
            }
        }
    }

    return count;
};