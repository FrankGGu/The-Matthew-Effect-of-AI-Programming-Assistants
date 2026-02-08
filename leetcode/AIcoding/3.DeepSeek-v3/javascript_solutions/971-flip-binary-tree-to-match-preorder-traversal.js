var flipMatchVoyage = function(root, voyage) {
    let res = [];
    let index = 0;

    function dfs(node) {
        if (!node) return true;
        if (node.val !== voyage[index++]) return false;

        if (node.left && node.left.val !== voyage[index]) {
            res.push(node.val);
            return dfs(node.right) && dfs(node.left);
        }
        return dfs(node.left) && dfs(node.right);
    }

    return dfs(root) ? res : [-1];
};