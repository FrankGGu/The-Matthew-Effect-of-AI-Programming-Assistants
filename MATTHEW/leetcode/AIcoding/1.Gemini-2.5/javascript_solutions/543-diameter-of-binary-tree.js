var diameterOfBinaryTree = function(root) {
    let maxDiameter = 0;

    function dfs(node) {
        if (!node) {
            return 0;
        }

        let leftHeight = dfs(node.left);
        let rightHeight = dfs(node.right);

        maxDiameter = Math.max(maxDiameter, leftHeight + rightHeight);

        return 1 + Math.max(leftHeight, rightHeight);
    }

    dfs(root);
    return maxDiameter;
};