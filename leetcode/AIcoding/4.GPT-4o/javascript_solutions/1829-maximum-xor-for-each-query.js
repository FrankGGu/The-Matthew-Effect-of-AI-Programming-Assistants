class TrieNode {
    constructor() {
        this.children = {};
        this.value = 0;
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
        node.value = num;
    }

    maxXor(num) {
        let node = this.root;
        let maxXor = 0;
        for (let i = 31; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const toggleBit = 1 - bit;
            if (node.children[toggleBit]) {
                maxXor |= (1 << i);
                node = node.children[toggleBit];
            } else {
                node = node.children[bit];
            }
        }
        return maxXor;
    }
}

var maximizeXor = function(nums, queries) {
    const sortedQueries = queries.map((q, idx) => [...q, idx]).sort((a, b) => a[0] - b[0]);
    const result = new Array(queries.length);
    const trie = new Trie();
    let j = 0;

    for (const [x, m, idx] of sortedQueries) {
        while (j < nums.length && nums[j] <= m) {
            trie.insert(nums[j]);
            j++;
        }
        result[idx] = j === 0 ? -1 : trie.maxXor(x);
    }

    return result;
};