var longestSpecialPath = function(root) {
    let maxLength = 0;

    const dfs = (node, prevValue, length) => {
        if (!node) return;
        if (node.val === prevValue + 1) {
            length += 1;
        } else {
            length = 1;
        }
        maxLength = Math.max(maxLength, length);
        dfs(node.left, node.val, length);
        dfs(node.right, node.val, length);
    };

    dfs(root, -1, 0);
    return maxLength;
};