var rob = function(root) {
    function dfs(node) {
        if (!node) {
            return [0, 0];
        }

        const left = dfs(node.left);
        const right = dfs(node.right);

        const robNode = node.val + left[1] + right[1];
        const skipNode = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return [robNode, skipNode];
    }

    const result = dfs(root);
    return Math.max(result[0], result[1]);
};