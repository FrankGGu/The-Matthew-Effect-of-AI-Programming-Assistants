var pathSum = function(root, targetSum) {
    const result = [];

    const dfs = (node, sum, path) => {
        if (!node) return;
        path.push(node.val);
        sum -= node.val;

        if (!node.left && !node.right && sum === 0) {
            result.push([...path]);
        }

        dfs(node.left, sum, path);
        dfs(node.right, sum, path);
        path.pop();
    };

    dfs(root, targetSum, []);
    return result;
};