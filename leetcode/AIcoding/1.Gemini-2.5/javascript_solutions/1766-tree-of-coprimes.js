var getCoprimes = function(nums, edges) {
    const n = nums.length;
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const ans = new Array(n).fill(-1);

    // last_seen_ancestor_info[value] stores [node_id, depth] of the most recent ancestor with that value
    // Initialize with [-1, -1] indicating no such ancestor seen yet
    const last_seen_ancestor_info = Array.from({ length: 51 }, () => [-1, -1]);

    // Helper GCD function
    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    const dfs = (u, p, d) => {
        // Find the nearest coprime ancestor for node u
        let bestAncestorNode = -1;
        let minDepthDiff = Infinity; // Represents depth difference from current node to ancestor

        for (let val = 1; val <= 50; val++) {
            if (gcd(nums[u], val) === 1) {
                const [ancestorNode, ancestorDepth] = last_seen_ancestor_info[val];
                if (ancestorNode !== -1) { // If an ancestor with 'val' exists
                    if (d - ancestorDepth <= minDepthDiff) {
                        minDepthDiff = d - ancestorDepth;
                        bestAncestorNode = ancestorNode;
                    }
                }
            }
        }
        ans[u] = bestAncestorNode;

        // Store current node's info before recursing
        const oldInfo = last_seen_ancestor_info[nums[u]];
        last_seen_ancestor_info[nums[u]] = [u, d];

        // Recurse for children
        for (const v of adj[u]) {
            if (v !== p) {
                dfs(v, u, d + 1);
            }
        }

        // Backtrack: restore previous state for nums[u]
        last_seen_ancestor_info[nums[u]] = oldInfo;
    };

    // Start DFS from node 0, parent -1, depth 0
    dfs(0, -1, 0);

    return ans;
};