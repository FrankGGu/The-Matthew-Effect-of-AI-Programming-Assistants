var solve = function(root) {
    if (!root) {
        return 0;
    }

    let sum = 0;

    function dfs(node) {
        if (!node) {
            return;
        }
        sum += node.val;
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);
    return sum;
};