var canMakePaliQueries = function(s, queries) {
    const n = s.length;
    const prefix = Array(n + 1).fill(0).map(() => Array(26).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < 26; j++) {
            prefix[i + 1][j] = prefix[i][j];
        }
        prefix[i + 1][s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const result = [];
    for (const query of queries) {
        const left = query[0];
        const right = query[1];
        const k = query[2];

        let oddCount = 0;
        for (let i = 0; i < 26; i++) {
            if ((prefix[right + 1][i] - prefix[left][i]) % 2 !== 0) {
                oddCount++;
            }
        }

        result.push(oddCount / 2 <= k);
    }

    return result;
};