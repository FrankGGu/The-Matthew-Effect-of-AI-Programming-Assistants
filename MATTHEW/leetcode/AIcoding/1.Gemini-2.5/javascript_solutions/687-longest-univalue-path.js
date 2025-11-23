var longestUnivaluePath = function(root) {
    let maxPath = 0;

    function dfs(node) {
        if (!node) {
            return 0;
        }

        let leftPath = dfs(node.left);
        let rightPath = dfs(node.right);

        let leftUnivaluePath = 0;
        let rightUnivaluePath = 0;

        if (node.left && node.left.val === node.val) {
            leftUnivaluePath = 1 + leftPath;
        }

        if (node.right && node.right.val === node.val) {
            rightUnivaluePath = 1 + rightPath;
        }

        maxPath = Math.max(maxPath, leftUnivaluePath + rightUnivaluePath);

        return Math.max(leftUnivaluePath, rightUnivaluePath);
    }

    dfs(root);
    return maxPath;
};