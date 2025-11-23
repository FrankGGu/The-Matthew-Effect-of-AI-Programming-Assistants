var checkWays = function(pairs) {
    const adj = new Map();
    for (const [u, v] of pairs) {
        if (!adj.has(u)) adj.set(u, new Set());
        if (!adj.has(v)) adj.set(v, new Set());
        adj.get(u).add(v);
        adj.get(v).add(u);
    }

    const nodes = Array.from(adj.keys()).sort((a, b) => adj.get(b).size - adj.get(a).size);
    const n = nodes.length;
    if (adj.get(nodes[0]).size !== n - 1) return 0;

    let res = 1;
    for (let i = 1; i < n; i++) {
        const u = nodes[i];
        let parent = -1;
        for (let j = 0; j < i; j++) {
            const v = nodes[j];
            if (adj.get(u).has(v)) {
                parent = v;
                break;
            }
        }
        if (parent === -1) return 0;
        for (const v of adj.get(u)) {
            if (v !== parent && !adj.get(parent).has(v)) {
                return 0;
            }
        }
        if (adj.get(u).size === adj.get(parent).size) {
            res = 2;
        }
    }
    return res;
};