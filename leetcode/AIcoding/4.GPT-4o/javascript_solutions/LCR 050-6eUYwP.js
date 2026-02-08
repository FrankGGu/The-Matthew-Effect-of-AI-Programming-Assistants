var pathSum = function(root, sum) {
    let count = 0;

    const dfs = (node, currSum) => {
        if (!node) return;
        currSum += node.val;
        if (currSum === sum) count++;
        dfs(node.left, currSum);
        dfs(node.right, currSum);
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