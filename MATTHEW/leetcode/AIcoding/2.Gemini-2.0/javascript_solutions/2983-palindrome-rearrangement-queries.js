var canRearrangeQueries = function(s, queries) {
    const n = s.length;
    const prefix = Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ (1 << (s.charCodeAt(i) - 'a'.charCodeAt(0)));
    }

    const result = [];
    for (const [l, r] of queries) {
        let mask = prefix[r + 1] ^ prefix[l];
        let ones = 0;
        for (let i = 0; i < 26; i++) {
            if ((mask >> i) & 1) {
                ones++;
            }
        }

        let len = r - l + 1;
        if (ones <= Math.floor((len + 1) / 2)) {
            result.push(true);
        } else {
            result.push(false);
        }
    }

    return result;
};