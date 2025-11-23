var pathSum = function(root, targetSum) {
    const result = [];
    const dfs = (node, sum, path) => {
        if (!node) return;
        sum += node.val;
        path.push(node.val);
        if (!node.left && !node.right && sum === targetSum) {
            result.push([...path]);
        }
        dfs(node.left, sum, path);
        dfs(node.right, sum, path);
        path.pop();
    };
    dfs(root, 0, []);
    return result;
};