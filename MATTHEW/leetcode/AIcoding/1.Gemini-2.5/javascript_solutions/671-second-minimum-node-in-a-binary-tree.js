var findSecondMinimumValue = function(root) {
    let min1 = root.val;
    let min2 = Infinity;

    function dfs(node) {
        if (node === null) {
            return;
        }

        if (node.val > min1) {
            if (node.val < min2) {
                min2 = node.val;
            }
            return;
        }

        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);

    return min2 === Infinity ? -1 : min2;
};