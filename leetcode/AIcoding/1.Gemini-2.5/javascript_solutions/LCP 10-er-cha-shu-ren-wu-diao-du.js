var rob = function(root) {
    function dfs(node) {
        if (!node) {
            return [0, 0];
        }

        let left = dfs(node.left);
        let right = dfs(node.right);

        let robCurrent = node.val + left[1] + right[1];
        let notRobCurrent = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return [robCurrent, notRobCurrent];
    }

    let result = dfs(root);
    return Math.max(result[0], result[1]);
};