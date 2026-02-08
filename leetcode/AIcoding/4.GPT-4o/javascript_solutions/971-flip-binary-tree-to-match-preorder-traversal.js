var flipMatchVoyage = function(root, voyage) {
    const result = [];
    let index = 0;

    function dfs(node) {
        if (!node) return true;
        if (node.val !== voyage[index++]) return false;

        if (node.left && node.left.val !== voyage[index]) {
            result.push(node.val);
            return dfs(node.right) && dfs(node.left);
        } 
        return dfs(node.left) && dfs(node.right);
    }

    if (!dfs(root)) return [-1];
    return result;
};