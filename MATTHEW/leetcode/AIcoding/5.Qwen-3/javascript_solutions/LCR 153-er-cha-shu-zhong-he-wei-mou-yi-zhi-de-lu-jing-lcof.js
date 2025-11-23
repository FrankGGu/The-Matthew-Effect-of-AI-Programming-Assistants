function pathSum(root, targetSum) {
    const result = [];

    function dfs(node, currentSum, path) {
        if (!node) return;

        currentSum += node.val;
        path.push(node.val);

        if (!node.left && !node.right && currentSum === targetSum) {
            result.push([...path]);
        }

        dfs(node.left, currentSum, path);
        dfs(node.right, currentSum, path);

        path.pop();
    }

    dfs(root, 0, []);
    return result;
}