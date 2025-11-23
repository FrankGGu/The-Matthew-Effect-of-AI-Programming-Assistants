function smallestFromLeaf(root) {
    let result = null;

    function dfs(node, path) {
        if (!node) return;
        path = String.fromCharCode(97 + node.val) + path;
        if (!node.left && !node.right) {
            if (!result || path < result) {
                result = path;
            }
            return;
        }
        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, "");
    return result;
}