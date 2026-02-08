var subtreeWithAllDeepest = function(root) {
    function dfs(node) {
        if (!node) {
            return [null, -1];
        }

        let [leftNode, leftDepth] = dfs(node.left);
        let [rightNode, rightDepth] = dfs(node.right);

        if (leftDepth === rightDepth) {
            return [node, leftDepth + 1];
        } else if (leftDepth > rightDepth) {
            return [leftNode, leftDepth + 1];
        } else {
            return [rightNode, rightDepth + 1];
        }
    }

    return dfs(root)[0];
};