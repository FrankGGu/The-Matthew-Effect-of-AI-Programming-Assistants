class TrieNode {
    constructor() {
        this.children = {};
        this.count = 0;
    }
}

class Solution {
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

    query(num) {
        let node = this.root;
        let res = 0;
        for (let i = 17; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const desiredBit = 1 - bit;
            if (node.children[desiredBit] && node.children[desiredBit].count > 0) {
                res += (1 << i);
                node = node.children[desiredBit];
            } else {
                node = node.children[bit];
            }
        }
        return res;
    }

    maxGeneticDifference(parents, queries) {
        const n = parents.length;
        const tree = Array.from({ length: n }, () => []);
        let root = -1;
        for (let i = 0; i < n; i++) {
            if (parents[i] === -1) {
                root = i;
            } else {
                tree[parents[i]].push(i);
            }
        }

        const queryMap = {};
        for (let i = 0; i < queries.length; i++) {
            const [node, val] = queries[i];
            if (!queryMap[node]) {
                queryMap[node] = [];
            }
            queryMap[node].push([val, i]);
        }

        const res = new Array(queries.length).fill(0);
        const dfs = (node) => {
            this.insert(node);
            if (queryMap[node]) {
                for (const [val, idx] of queryMap[node]) {
                    res[idx] = this.query(val);
                }
            }
            for (const child of tree[node]) {
                dfs(child);
            }
            this.remove(node);
        };

        dfs(root);
        return res;
    }
}

var maxGeneticDifference = function(parents, queries) {
    const solution = new Solution();
    return solution.maxGeneticDifference(parents, queries);
};