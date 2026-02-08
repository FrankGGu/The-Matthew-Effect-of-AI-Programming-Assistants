var canMakePaliQueries = function(s, queries) {
    const count = Array.from({ length: s.length + 1 }, () => new Array(26).fill(0));

    for (let i = 0; i < s.length; i++) {
        for (let j = 0; j < 26; j++) {
            count[i + 1][j] = count[i][j];
        }
        count[i + 1][s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const result = [];
    for (const [left, right, k] of queries) {
        let oddCount = 0;
        for (let j = 0; j < 26; j++) {
            if ((count[right + 1][j] - count[left][j]) % 2 === 1) {
                oddCount++;
            }
        }
        result.push(oddCount / 2 <= k);
    }

    return result;
};