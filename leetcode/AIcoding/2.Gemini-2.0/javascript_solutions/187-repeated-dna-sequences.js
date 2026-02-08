var findRepeatedDnaSequences = function(s) {
    const k = 10;
    const n = s.length;
    if (n < k) {
        return [];
    }

    const seen = new Set();
    const repeated = new Set();
    const ans = [];

    for (let i = 0; i <= n - k; i++) {
        const sub = s.substring(i, i + k);
        if (seen.has(sub)) {
            if (!repeated.has(sub)) {
                ans.push(sub);
                repeated.add(sub);
            }
        } else {
            seen.add(sub);
        }
    }

    return ans;
};