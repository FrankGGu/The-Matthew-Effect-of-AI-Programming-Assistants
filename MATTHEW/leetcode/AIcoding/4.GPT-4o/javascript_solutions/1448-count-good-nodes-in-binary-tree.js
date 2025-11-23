var goodNodes = function(root) {
    let count = 0;

    const dfs = (node, maxValue) => {
        if (!node) return;
        if (node.val >= maxValue) {
            count++;
            maxValue = node.val;
        }
        dfs(node.left, maxValue);
        dfs(node.right, maxValue);
    };

    dfs(root, root.val);
    return count;
};