class TrieNode {
    constructor() {
        this.children = [null, null];
        this.count = 0;
    }
}

class Trie {
    constructor(maxBit = 29) {
        this.root = new TrieNode();
        this.maxBit = maxBit;
    }

    insert(num) {
        let curr = this.root;
        for (let i = this.maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!curr.children[bit]) {
                curr.children[bit] = new TrieNode();
            }
            curr = curr.children[bit];
            curr.count++;
        }
    }

    remove(num) {
        let curr = this.root;
        for (let i = this.maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            curr = curr.children[bit];
            curr.count--;
        }
    }

    queryMaxXor(num) {
        let curr = this.root;
        let maxXor = 0;
        for (let i = this.maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const desiredBit = 1 - bit;

            if (curr.children[desiredBit] && curr.children[desiredBit].count > 0) {
                maxXor |= (1 << i);
                curr = curr.children[desiredBit];
            } else if (curr.children[bit] && curr.children[bit].count > 0) {
                curr = curr.children[bit];
            } else {
                // This case should not be reached if the Trie is guaranteed to contain values.
                // For this problem, at least the current node's value will be in the Trie.
                return 0; 
            }
        }
        return maxXor;
    }
}

function maxGeneticDifference(parents, nums, queries) {
    const n = parents.length;
    const adj = Array.from({ length: n }, () => []);
    const root = 0;

    for (let i = 0; i < n; i++) {
        if (parents[i] !== -1) {
            adj[parents[i]].push(i);
        }
    }

    const queriesAtNode = Array.from({ length: n }, () => []);
    const results = new Array(queries.length);

    for (let i = 0; i < queries.length; i++) {
        const [node, val] = queries[i];
        queriesAtNode[node].push([val, i]);
    }

    const trie = new Trie();

    function dfs(u) {
        trie.insert(nums[u]);

        for (const [val, queryIndex] of queriesAtNode[u]) {
            results[queryIndex] = trie.queryMaxXor(val);
        }

        for (const v of adj[u]) {
            dfs(v);
        }

        trie.remove(nums[u]);
    }

    dfs(root);

    return results;
}