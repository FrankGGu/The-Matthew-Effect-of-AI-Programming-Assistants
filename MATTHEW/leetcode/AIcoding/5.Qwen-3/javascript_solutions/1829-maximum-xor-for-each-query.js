function maximizeXOR(nums, queries) {
    nums.sort((a, b) => a - b);
    const sortedQueries = queries.map((q, i) => ({ val: q, index: i }));
    sortedQueries.sort((a, b) => a.val - b.val);

    const result = new Array(queries.length);
    const trie = {};

    let numIndex = 0;

    for (const query of sortedQueries) {
        const { val: x, index: i } = query;
        while (numIndex < nums.length && nums[numIndex] <= x) {
            let node = trie;
            for (let j = 31; j >= 0; j--) {
                const bit = (nums[numIndex] >> j) & 1;
                if (!node[bit]) node[bit] = {};
                node = node[bit];
            }
            numIndex++;
        }

        let maxXor = 0;
        let node = trie;
        for (let j = 31; j >= 0; j--) {
            const bit = (x >> j) & 1;
            const desiredBit = 1 - bit;
            if (node[desiredBit]) {
                maxXor |= (1 << j);
                node = node[desiredBit];
            } else {
                node = node[bit] || {};
            }
        }

        result[i] = maxXor;
    }

    return result;
}