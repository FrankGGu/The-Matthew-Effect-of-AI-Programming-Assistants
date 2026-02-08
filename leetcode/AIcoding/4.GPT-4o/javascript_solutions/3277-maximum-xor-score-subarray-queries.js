class TrieNode {
    constructor() {
        this.children = {};
        this.count = 0;
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
            node.count++;
        }
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

var maximumXor = function(nums, queries) {
    const n = nums.length;
    const m = queries.length;
    const results = new Array(m).fill(0);
    const sortedQueries = queries.map((q, i) => [q[0], q[1], i]).sort((a, b) => a[1] - b[1]);
    const trie = new Trie();
    let currentXor = 0;
    let j = 0;

    for (let i = 0; i < m; i++) {
        while (j < n && nums[j] <= sortedQueries[i][1]) {
            trie.insert(nums[j]);
            currentXor ^= nums[j];
            j++;
        }
        results[sortedQueries[i][2]] = trie.maxXor(currentXor);
    }

    return results;
};