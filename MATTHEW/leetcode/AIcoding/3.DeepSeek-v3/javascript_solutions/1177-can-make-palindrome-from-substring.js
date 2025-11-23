var canMakePaliQueries = function(s, queries) {
    const n = s.length;
    const prefix = new Array(n + 1).fill(0).map(() => new Array(26).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 26; j++) {
            prefix[i + 1][j] = prefix[i][j];
        }
        prefix[i + 1][s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }
    const res = [];
    for (const [left, right, k] of queries) {
        let odd = 0;
        for (let i = 0; i < 26; i++) {
            const cnt = prefix[right + 1][i] - prefix[left][i];
            if (cnt % 2 !== 0) {
                odd++;
            }
        }
        res.push(odd <= 2 * k + 1);
    }
    return res;
};