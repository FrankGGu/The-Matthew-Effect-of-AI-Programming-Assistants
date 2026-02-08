var countPairs = function(root, distance) {
    let result = 0;

    function dfs(node) {
        if (!node) return [];
        if (!node.left && !node.right) return [1];

        const left = dfs(node.left);
        const right = dfs(node.right);

        for (const l of left) {
            for (const r of right) {
                if (l + r <= distance) {
                    result++;
                }
            }
        }

        const res = [];
        for (const l of left) {
            if (l + 1 <= distance) {
                res.push(l + 1);
            }
        }
        for (const r of right) {
            if (r + 1 <= distance) {
                res.push(r + 1);
            }
        }
        return res;
    }

    dfs(root);
    return result;
};