var maxGeneticDifference = function(parents, queries) {
    const n = parents.length;
    const root = parents.indexOf(-1);
    const adj = Array(n).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        if (parents[i] !== -1) {
            adj[parents[i]].push(i);
        }
    }

    const trie = new Trie();
    const ans = Array(queries.length);
    const queryMap = Array(n).fill(null).map(() => []);

    for (let i = 0; i < queries.length; i++) {
        queryMap[queries[i][0]].push([queries[i][1], i]);
    }

    function dfs(node) {
        trie.insert(node);

        for (const [val, idx] of queryMap[node]) {
            ans[idx] = trie.getMaxXor(val);
        }

        for (const neighbor of adj[node]) {
            dfs(neighbor);
        }

        trie.remove(node);
    }

    dfs(root);
    return ans;
};

class TrieNode {
    constructor() {
        this.children = new Array(2).fill(null);
        this.count = 0;
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
    }

    insert(num) {
        let node = this.root;
        for (let i = 17; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
            node.count++;
        }
    }

    remove(num) {
        let node = this.root;
        for (let i = 17; i >= 0; i--) {
            const bit = (num >> i) & 1;
            node = node.children[bit];
            node.count--;
        }
    }

    getMaxXor(num) {
        let node = this.root;
        let maxXor = 0;
        for (let i = 17; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const oppositeBit = 1 - bit;
            if (node.children[oppositeBit] && node.children[oppositeBit].count > 0) {
                maxXor |= (1 << i);
                node = node.children[oppositeBit];
            } else {
                node = node.children[bit];
            }
        }
        return maxXor;
    }
}