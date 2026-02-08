var maxValue = function(root, k) {
    const memo = new Map();

    const dfs = (node) => {
        if (!node) return new Array(k + 1).fill(0);
        if (memo.has(node)) return memo.get(node);

        const left = dfs(node.left);
        const right = dfs(node.right);

        const res = new Array(k + 1).fill(0);

        // Option 1: Not coloring the current node
        let maxLeft = 0, maxRight = 0;
        for (let i = 0; i <= k; i++) {
            maxLeft = Math.max(maxLeft, left[i]);
            maxRight = Math.max(maxRight, right[i]);
        }
        res[0] = maxLeft + maxRight;

        // Option 2: Coloring the current node
        for (let i = 0; i < k; i++) {
            for (let j = 0; j < k; j++) {
                if (i + j + 1 <= k) {
                    res[i + j + 1] = Math.max(res[i + j + 1], left[i] + right[j] + node.val);
                }
            }
        }

        memo.set(node, res);
        return res;
    };

    const result = dfs(root);
    return Math.max(...result);
};