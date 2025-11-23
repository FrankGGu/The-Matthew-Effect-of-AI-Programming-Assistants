class TrieNode {
    constructor() {
        this.children = {};
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(num) {
        let node = this.root;
        for (let i = 31; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    }

    findMaxXOR(num) {
        let node = this.root;
        let maxXOR = 0;
        for (let i = 31; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const toggleBit = 1 - bit;
            if (node.children[toggleBit]) {
                maxXOR += (1 << i);
                node = node.children[toggleBit];
            } else {
                node = node.children[bit] || node.children[toggleBit];
            }
        }
        return maxXOR;
    }
}

var maximizeXor = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const indexedQueries = queries.map((query, index) => [...query, index]);
    indexedQueries.sort((a, b) => a[1] - b[1]);

    const trie = new Trie();
    let ptr = 0;
    const result = new Array(queries.length).fill(-1);

    for (const [xi, mi, originalIndex] of indexedQueries) {
        while (ptr < nums.length && nums[ptr] <= mi) {
            trie.insert(nums[ptr]);
            ptr++;
        }
        if (ptr > 0) {
            result[originalIndex] = trie.findMaxXOR(xi);
        }
    }

    return result;
};