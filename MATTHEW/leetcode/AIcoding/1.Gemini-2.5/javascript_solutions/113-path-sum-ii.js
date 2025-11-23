var pathSum = function(root, targetSum) {
    const result = [];

    function dfs(node, currentSum, currentPath) {
        if (!node) {
            return;
        }

        currentPath.push(node.val);
        currentSum += node.val;

        if (!node.left && !node.right && currentSum === targetSum) {
            result.push([...currentPath]);
        }

        dfs(node.left, currentSum, currentPath);
        dfs(node.right, currentSum, currentPath);

        currentPath.pop();
    }

    dfs(root, 0, []);
    return result;
};