var rightSideView = function(root) {
    const result = [];
    const dfs = (node, level) => {
        if (!node) return;
        if (result.length === level) {
            result.push(node.val);
        }
        dfs(node.right, level + 1);
        dfs(node.left, level + 1);
    };
    dfs(root, 0);
    return result;
};