var isUnivalTree = function(root) {
    if (!root) return true;

    let val = root.val;

    function dfs(node) {
        if (!node) return true;

        if (node.val !== val) return false;

        return dfs(node.left) && dfs(node.right);
    }

    return dfs(root);
};