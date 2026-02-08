var findSecondMinimumValue = function(root) {
    let min1 = root.val;
    let ans = Infinity;

    function dfs(node) {
        if (!node) return;

        if (node.val > min1 && node.val < ans) {
            ans = node.val;
        }

        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);

    return ans === Infinity ? -1 : ans;
};