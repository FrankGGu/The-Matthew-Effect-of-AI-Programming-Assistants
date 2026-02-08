var longestZigZag = function(root) {
    let max = 0;

    const dfs = (node, direction) => {
        if (!node) return 0;

        const left = dfs(node.left, 'left');
        const right = dfs(node.right, 'right');

        if (direction === 'left') {
            return left + 1;
        } else {
            return right + 1;
        }
    };

    const traverse = (node) => {
        if (!node) return;

        max = Math.max(max, dfs(node.left, 'left'), dfs(node.right, 'right'));
        traverse(node.left);
        traverse(node.right);
    };

    traverse(root);
    return max;
};