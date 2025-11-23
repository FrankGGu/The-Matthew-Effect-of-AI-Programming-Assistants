var longestZigZag = function(root) {
    let max = 0;

    const dfs = (node, left, right) => {
        if (!node) return;
        max = Math.max(max, left, right);
        dfs(node.left, right + 1, 0);
        dfs(node.right, 0, left + 1);
    };

    dfs(root, 0, 0);
    return max;
};