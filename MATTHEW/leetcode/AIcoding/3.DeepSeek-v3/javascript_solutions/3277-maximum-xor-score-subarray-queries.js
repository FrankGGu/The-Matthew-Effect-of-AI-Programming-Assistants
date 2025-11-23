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
                node = node.children[bit];
            }
        }
        return maxXOR;
    }
}

var maxXorSubarray = function(nums) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ nums[i];
    }

    const trie = new Trie();
    trie.insert(0);
    let max = 0;
    for (let i = 1; i <= n; i++) {
        max = Math.max(max, trie.findMaxXOR(prefix[i]));
        trie.insert(prefix[i]);
    }
    return max;
};

var maxXorQueries = function(nums, queries) {
    const n = nums.length;
    const m = queries.length;
    const res = new Array(m).fill(0);
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ nums[i];
    }

    for (let i = 0; i < m; i++) {
        const [l, r] = queries[i];
        const trie = new Trie();
        trie.insert(prefix[l]);
        let max = 0;
        for (let j = l + 1; j <= r + 1; j++) {
            max = Math.max(max, trie.findMaxXOR(prefix[j]));
            trie.insert(prefix[j]);
        }
        res[i] = max;
    }
    return res;
};