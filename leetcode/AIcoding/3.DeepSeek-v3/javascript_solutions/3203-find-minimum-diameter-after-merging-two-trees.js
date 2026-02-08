var findMinDiameter = function(tree1, tree2) {
    function getDiameter(tree) {
        if (!tree || tree.length === 0) return 0;
        const n = tree.length;
        const adj = Array.from({ length: n }, () => []);
        for (let i = 0; i < n; i++) {
            for (const neighbor of tree[i]) {
                adj[i].push(neighbor);
            }
        }

        let diameter = 0;
        function dfs(node, parent) {
            let max1 = 0, max2 = 0;
            for (const neighbor of adj[node]) {
                if (neighbor === parent) continue;
                const depth = dfs(neighbor, node);
                if (depth > max1) {
                    max2 = max1;
                    max1 = depth;
                } else if (depth > max2) {
                    max2 = depth;
                }
            }
            diameter = Math.max(diameter, max1 + max2);
            return 1 + max1;
        }
        dfs(0, -1);
        return diameter;
    }

    const d1 = getDiameter(tree1);
    const d2 = getDiameter(tree2);
    const r1 = Math.ceil(d1 / 2);
    const r2 = Math.ceil(d2 / 2);
    return Math.max(d1, d2, r1 + r2 + 1);
};