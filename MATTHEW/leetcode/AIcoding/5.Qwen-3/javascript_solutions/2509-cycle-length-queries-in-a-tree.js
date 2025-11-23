function cycleLengthQueries(root, queries) {
    const parent = new Map();
    const depth = new Map();

    function dfs(node, p, d) {
        parent.set(node.val, p ? p.val : -1);
        depth.set(node.val, d);
        if (node.left) dfs(node.left, node, d + 1);
        if (node.right) dfs(node.right, node, d + 1);
    }

    dfs(root, null, 0);

    const result = [];
    for (const [u, v] of queries) {
        let lca = u;
        let lcaDepth = depth.get(u);
        let other = v;
        let otherDepth = depth.get(v);

        while (lca !== other) {
            if (lcaDepth > otherDepth) {
                lca = parent.get(lca);
                lcaDepth--;
            } else {
                other = parent.get(other);
                otherDepth--;
            }
        }

        result.push(depth.get(u) + depth.get(v) - 2 * depth.get(lca));
    }

    return result;
}