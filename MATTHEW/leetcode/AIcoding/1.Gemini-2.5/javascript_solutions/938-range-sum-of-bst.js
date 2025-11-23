var rangeSumBST = function(root, low, high) {
    let sum = 0;

    function dfs(node) {
        if (!node) {
            return;
        }

        if (node.val >= low && node.val <= high) {
            sum += node.val;
        }

        if (node.val > low) {
            dfs(node.left);
        }
        if (node.val < high) {
            dfs(node.right);
        }
    }

    dfs(root);
    return sum;
};