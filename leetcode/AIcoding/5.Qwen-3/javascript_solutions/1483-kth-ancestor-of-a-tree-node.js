function kthAncestor(root, queries) {
    const parent = {};
    const depth = {};

    function dfs(node, p, d) {
        if (!node) return;
        parent[node.val] = p;
        depth[node.val] = d;
        dfs(node.left, node.val, d + 1);
        dfs(node.right, node.val, d + 1);
    }

    dfs(root, -1, 0);

    const result = [];

    for (const q of queries) {
        let curr = q;
        for (let i = 0; i < k; i++) {
            if (curr === -1) break;
            curr = parent[curr];
        }
        result.push(curr);
    }

    return result;
}