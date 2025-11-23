var canMakePaliQueries = function(s, queries) {
    const n = s.length;
    const prefixXorMasks = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        prefixXorMasks[i + 1] = prefixXorMasks[i] ^ (1 << charCode);
    }

    const results = [];

    function countSetBits(num) {
        let count = 0;
        while (num > 0) {
            num &= (num - 1);
            count++;
        }
        return count;
    }

    for (const query of queries) {
        const [left, right, k] = query;

        const subMask = prefixXorMasks[right + 1] ^ prefixXorMasks[left];

        const oddCounts = countSetBits(subMask);

        const changesNeeded = Math.floor(oddCounts / 2);

        results.push(changesNeeded <= k);
    }

    return results;
};