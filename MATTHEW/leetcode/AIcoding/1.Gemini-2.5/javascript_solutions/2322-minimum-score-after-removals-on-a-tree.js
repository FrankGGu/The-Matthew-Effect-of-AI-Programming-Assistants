var minimumScore = function(n, edges, values) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const subTreeXor = Array(n).fill(0);
    const parents = Array(n).fill(-1);
    const disc = Array(n).fill(0); // discovery time
    const fin = Array(n).fill(0);  // finish time
    let timer = 0;

    function dfs(u, p) {
        parents[u] = p;
        subTreeXor[u] = values[u];
        disc[u] = timer++;

        for (const v of adj[u]) {
            if (v === p) continue;
            dfs(v, u);
            subTreeXor[u] ^= subTreeXor[v];
        }
        fin[u] = timer++;
    }

    dfs(0, -1); // Start DFS from root 0, parent -1

    const totalXor = subTreeXor[0];
    let minScore = Infinity;

    // Iterate through all possible pairs of distinct edges to remove.
    // An edge is uniquely identified by its child node (since parents[child] is unique).
    // We iterate through all possible child nodes c1 and c2 (from 1 to n-1).
    // Node 0 is the root and cannot be a child node for an edge removal.
    for (let c1 = 1; c1 < n; c1++) {
        for (let c2 = c1 + 1; c2 < n; c2++) {
            let xor1, xor2, xor3;

            // Check if c1 is an ancestor of c2 (or vice versa) using discovery and finish times.
            // u is an ancestor of v if disc[u] <= disc[v] and fin[u] >= fin[v].
            const isC1AncestorOfC2 = (disc[c1] <= disc[c2] && fin[c1] >= fin[c2]);
            const isC2AncestorOfC1 = (disc[c2] <= disc[c1] && fin[c2] >= fin[c1]);

            if (isC1AncestorOfC2) {
                // Edge 1: (parents[c1], c1)
                // Edge 2: (parents[c2], c2)
                // c2 is in the subtree of c1.
                // The three components are:
                // 1. Subtree rooted at c2.
                // 2. Part of c1's subtree, excluding c2's subtree.
                // 3. The rest of the tree (original tree minus c1's subtree).
                xor1 = subTreeXor[c2];
                xor2 = subTreeXor[c1] ^ subTreeXor[c2];
                xor3 = totalXor ^ subTreeXor[c1];
            } else if (isC2AncestorOfC1) {
                // c1 is in the subtree of c2.
                // The three components are:
                // 1. Subtree rooted at c1.
                // 2. Part of c2's subtree, excluding c1's subtree.
                // 3. The rest of the tree (original tree minus c2's subtree).
                xor1 = subTreeXor[c1];
                xor2 = subTreeXor[c2] ^ subTreeXor[c1];
                xor3 = totalXor ^ subTreeXor[c2];
            } else {
                // No ancestor-descendant relationship between c1 and c2.
                // The three components are:
                // 1. Subtree rooted at c1.
                // 2. Subtree rooted at c2.
                // 3. The rest of the tree (original tree minus both c1's and c2's subtrees).
                xor1 = subTreeXor[c1];
                xor2 = subTreeXor[c2];
                xor3 = totalXor ^ subTreeXor[c1] ^ subTreeXor[c2];
            }

            const currentMax = Math.max(xor1, xor2, xor3);
            const currentMin = Math.min(xor1, xor2, xor3);
            minScore = Math.min(minScore, currentMax - currentMin);
        }
    }

    return minScore;
};