var canMakePalindromeQueries = function(s, queries) {
    const n = s.length;
    const charCount = 26;

    const prefixSums = Array(n + 1).fill(0).map(() => Array(charCount).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < charCount; j++) {
            prefixSums[i + 1][j] = prefixSums[i][j];
        }
        const charIndex = s.charCodeAt(i) - 'a'.charCodeAt(0);
        prefixSums[i + 1][charIndex]++;
    }

    const results = [];

    for (const query of queries) {
        const [l, r, k] = query;
        let odd_counts = 0;

        for (let j = 0; j < charCount; j++) {
            const freq_j = prefixSums[r + 1][j] - prefixSums[l][j];
            if (freq_j % 2 !== 0) {
                odd_counts++;
            }
        }

        if (Math.floor(odd_counts / 2) <= k) {
            results.push(true);
        } else {
            results.push(false);
        }
    }

    return results;
};