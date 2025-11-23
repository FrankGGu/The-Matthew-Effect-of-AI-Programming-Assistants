var pathSum = function(root, targetSum) {
    let count = 0;

    const dfs = (node, currentSum) => {
        if (!node) return;

        if (currentSum + node.val === targetSum) {
            count++;
        }

        dfs(node.left, currentSum + node.val);
        dfs(node.right, currentSum + node.val);
    };

    const traverse = (node) => {
        if (!node) return;

        dfs(node, 0);
        traverse(node.left);
        traverse(node.right);
    };

    traverse(root);
    return count;
};