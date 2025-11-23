function maximumXOR(nums, queries) {
    const maxBit = 30;
    const trie = {};

    function insert(num) {
        let node = trie;
        for (let i = maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node[bit]) {
                node[bit] = {};
            }
            node = node[bit];
        }
    }

    function query(num) {
        let node = trie;
        let maxXor = 0;
        for (let i = maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const toggledBit = 1 - bit;
            if (node[toggledBit]) {
                maxXor |= (1 << i);
                node = node[toggledBit];
            } else {
                node = node[bit] || {};
            }
        }
        return maxXor;
    }

    for (const num of nums) {
        insert(num);
    }

    const result = [];
    for (const [index, val] of queries.entries()) {
        result[index] = query(val);
    }

    return result;
}