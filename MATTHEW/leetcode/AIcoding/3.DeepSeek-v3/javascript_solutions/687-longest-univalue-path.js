var longestUnivaluePath = function(root) {
    let max = 0;

    const dfs = (node) => {
        if (!node) return 0;
        let left = dfs(node.left);
        let right = dfs(node.right);
        let leftPath = 0, rightPath = 0;
        if (node.left && node.left.val === node.val) {
            leftPath = left + 1;
        }
        if (node.right && node.right.val === node.val) {
            rightPath = right + 1;
        }
        max = Math.max(max, leftPath + rightPath);
        return Math.max(leftPath, rightPath);
    };

    dfs(root);
    return max;
};