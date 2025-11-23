var pathSum = function(root, targetSum) {
    const result = [];
    const path = [];

    function dfs(node, currentSum) {
        if (!node) return;

        path.push(node.val);
        currentSum += node.val;

        if (!node.left && !node.right && currentSum === targetSum) {
            result.push([...path]);
        }

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);

        path.pop();
    }

    dfs(root, 0);
    return result;
};