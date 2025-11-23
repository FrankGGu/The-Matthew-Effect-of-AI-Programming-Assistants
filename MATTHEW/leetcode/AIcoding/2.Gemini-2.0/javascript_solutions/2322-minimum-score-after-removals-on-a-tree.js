var minimumScore = function(nums, edges) {
    const n = nums.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const subtreeXor = Array(n).fill(0);
    const parent = Array(n).fill(-1);
    const depth = Array(n).fill(0);

    function dfs(node, par, d) {
        parent[node] = par;
        depth[node] = d;
        subtreeXor[node] = nums[node];
        for (const neighbor of adj[node]) {
            if (neighbor !== par) {
                dfs(neighbor, node, d + 1);
                subtreeXor[node] ^= subtreeXor[neighbor];
            }
        }
    }

    dfs(0, -1, 0);

    let minScore = Infinity;

    for (let i = 1; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let a, b, c;

            if (isAncestor(i, j)) {
                a = subtreeXor[j];
                b = subtreeXor[i] ^ subtreeXor[j];
                c = subtreeXor[0] ^ subtreeXor[i];
            } else if (isAncestor(j, i)) {
                a = subtreeXor[i];
                b = subtreeXor[j] ^ subtreeXor[i];
                c = subtreeXor[0] ^ subtreeXor[j];
            } else {
                a = subtreeXor[i];
                b = subtreeXor[j];
                c = subtreeXor[0] ^ subtreeXor[i] ^ subtreeXor[j];
            }

            const score = Math.max(a, b, c) - Math.min(a, b, c);
            minScore = Math.min(minScore, score);
        }
    }

    function isAncestor(node1, node2) {
        while (node2 !== -1) {
            if (node2 === node1) {
                return true;
            }
            node2 = parent[node2];
        }
        return false;
    }

    return minScore;
};