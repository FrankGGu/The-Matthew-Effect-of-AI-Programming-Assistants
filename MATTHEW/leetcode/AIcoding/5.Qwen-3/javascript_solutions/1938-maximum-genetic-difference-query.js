function maximumGeneticDifference(parents, queries) {
    const n = parents.length;
    const tree = Array.from({ length: n }, () => []);
    for (let i = 0; i < n; i++) {
        if (parents[i] !== -1) {
            tree[parents[i]].push(i);
        }
    }

    const result = new Array(queries.length).fill(0);
    const queryIndices = new Array(queries.length).fill(0).map((_, i) => i);
    queryIndices.sort((a, b) => queries[a][1] - queries[b][1]);

    const trie = { children: [null, null], count: 0 };
    const maxBit = 17;

    function insert(num) {
        let node = trie;
        for (let i = maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = { children: [null, null], count: 0 };
            }
            node = node.children[bit];
            node.count++;
        }
    }

    function remove(num) {
        let node = trie;
        for (let i = maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            node = node.children[bit];
            node.count--;
        }
    }

    function maxDiff(num) {
        let node = trie;
        let max = 0;
        for (let i = maxBit; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const toggle = 1 - bit;
            if (node.children[toggle] && node.children[toggle].count > 0) {
                max |= (1 << i);
                node = node.children[toggle];
            } else {
                node = node.children[bit] || node.children[toggle];
            }
        }
        return max;
    }

    const visited = new Array(n).fill(false);
    const stack = [];
    const dfs = (node) => {
        visited[node] = true;
        insert(node);
        for (const q of queryIndices) {
            const [u, v] = queries[q];
            if (u === node) {
                result[q] = maxDiff(v);
            }
        }
        for (const child of tree[node]) {
            if (!visited[child]) {
                dfs(child);
            }
        }
        remove(node);
        visited[node] = false;
    };

    dfs(0);

    return result;
}