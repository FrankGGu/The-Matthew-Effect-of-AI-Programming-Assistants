var countPalindromePaths = function(parent, s) {
    const n = parent.length;
    const graph = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        graph[parent[i]].push(i);
    }

    let res = 0;
    const freq = new Map();
    freq.set(0, 1);

    const dfs = (node, mask) => {
        const c = s.charCodeAt(node) - 97;
        mask ^= (1 << c);

        res += freq.get(mask) || 0;
        for (let i = 0; i < 26; i++) {
            const tempMask = mask ^ (1 << i);
            res += freq.get(tempMask) || 0;
        }

        freq.set(mask, (freq.get(mask) || 0) + 1);

        for (const child of graph[node]) {
            dfs(child, mask);
        }
    };

    dfs(0, 0);
    return res;
};