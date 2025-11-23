var longestUnivaluePath = function(root) {
    let maxLen = 0;

    function dfs(node) {
        if (!node) return 0;

        let leftLen = dfs(node.left);
        let rightLen = dfs(node.right);

        let arrowLeft = 0;
        let arrowRight = 0;

        if (node.left && node.left.val === node.val) {
            arrowLeft = leftLen + 1;
        }

        if (node.right && node.right.val === node.val) {
            arrowRight = rightLen + 1;
        }

        maxLen = Math.max(maxLen, arrowLeft + arrowRight);

        return Math.max(arrowLeft, arrowRight);
    }

    dfs(root);
    return maxLen;
};