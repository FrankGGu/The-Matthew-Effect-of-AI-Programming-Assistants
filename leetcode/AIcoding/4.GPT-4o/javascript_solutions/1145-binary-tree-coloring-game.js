var btreeGameWinningMove = function(root, n, x) {
    let left = 0, right = 0;

    const dfs = (node) => {
        if (!node) return 0;
        let count = 1 + dfs(node.left) + dfs(node.right);
        if (node.val === x) {
            left = dfs(node.left);
            right = dfs(node.right);
        }
        return count;
    };

    dfs(root);
    return Math.max(left, right, n - left - right - 1) > n / 2;
};