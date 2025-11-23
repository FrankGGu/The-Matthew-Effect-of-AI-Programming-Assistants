var rob = function(root) {
    function dfs(node) {
        if (!node) {
            return [0, 0];
        }

        const left = dfs(node.left);
        const right = dfs(node.right);

        const robbed_current = node.val + left[1] + right[1];

        const not_robbed_current = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return [robbed_current, not_robbed_current];
    }

    const result = dfs(root);
    return Math.max(result[0], result[1]);
};