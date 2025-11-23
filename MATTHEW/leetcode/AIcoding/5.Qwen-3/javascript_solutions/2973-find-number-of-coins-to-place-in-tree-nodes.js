function findNumberOfCoins(root) {
    let count = 0;

    function dfs(node) {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);

        const total = node.val + left + right;
        count += Math.abs(left - right);

        return total;
    }

    dfs(root);
    return count;
}