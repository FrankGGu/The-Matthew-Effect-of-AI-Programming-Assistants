var smallestFromLeaf = function(root) {
    let minString = null;

    function dfs(node, path) {
        if (!node) return;
        path = String.fromCharCode(node.val + 97) + path;
        if (!node.left && !node.right) {
            if (minString === null || path < minString) {
                minString = path;
            }
        }
        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, "");
    return minString;
};