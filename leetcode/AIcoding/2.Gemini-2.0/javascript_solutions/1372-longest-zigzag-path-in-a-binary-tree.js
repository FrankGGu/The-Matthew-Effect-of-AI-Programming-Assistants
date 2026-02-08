var longestZigZag = function(root) {
    let maxLen = 0;

    function dfs(node, direction, len) {
        if (!node) {
            return;
        }

        maxLen = Math.max(maxLen, len);

        if (direction === 'left') {
            dfs(node.left, 'right', 1);
            dfs(node.right, 'left', len + 1);
        } else {
            dfs(node.right, 'left', 1);
            dfs(node.left, 'right', len + 1);
        }
    }

    dfs(root.left, 'right', 1);
    dfs(root.right, 'left', 1);

    return maxLen;
};