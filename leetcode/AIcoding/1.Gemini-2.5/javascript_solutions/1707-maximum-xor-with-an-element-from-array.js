class TrieNode {
    constructor() {
        this.children = new Array(2).fill(null);
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
        this.MAX_BITS = 30; 
    }

    insert(num) {
        let node = this.root;
        for (let i = this.MAX_BITS; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    }

    getMaxXor(num) {
        let node = this.root;
        let maxXor = 0;
        for (let i = this.MAX_BITS; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const oppositeBit = 1 - bit;

            if (node.children[oppositeBit]) {
                maxXor |= (1 << i);
                node = node.children[oppositeBit];
            } else {
                node = node.children[bit];
            }
        }
        return maxXor;
    }
}

var maximizeXor = function(nums, queries) {
    nums.sort((a, b) => a - b);

    const processedQueries = queries.map((q, index) => [q[0], q[1], index]);
    processedQueries.sort((a, b) => a[1] - b[1]);

    const results = new Array(queries.length).fill(-1);
    const trie = new Trie();
    let numIdx = 0;

    for (let i = 0; i < processedQueries.length; i++) {
        const [xi, mi, originalIndex] = processedQueries[i];

        while (numIdx < nums.length && nums[numIdx] <= mi) {
            trie.insert(nums[numIdx]);
            numIdx++;
        }

        if (numIdx > 0) {
            results[originalIndex] = trie.getMaxXor(xi);
        }
    }

    return results;
};