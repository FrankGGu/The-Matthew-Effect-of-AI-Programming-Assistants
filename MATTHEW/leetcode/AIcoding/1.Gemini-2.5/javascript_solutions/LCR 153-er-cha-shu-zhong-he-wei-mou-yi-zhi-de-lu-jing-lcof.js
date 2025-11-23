var pathSum = function(root, targetSum) {
    const result = [];
    const currentPath = [];

    function dfs(node, remainingSum) {
        if (!node) {
            return;
        }

        currentPath.push(node.val);
        remainingSum -= node.val;

        if (!node.left && !node.right && remainingSum === 0) {
            result.push([...currentPath]);
        }

        dfs(node.left, remainingSum);
        dfs(node.right, remainingSum);

        currentPath.pop();
    }

    dfs(root, targetSum);
    return result;
};