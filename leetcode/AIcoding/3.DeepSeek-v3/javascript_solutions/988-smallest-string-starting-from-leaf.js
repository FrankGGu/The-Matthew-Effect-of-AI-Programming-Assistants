var smallestFromLeaf = function(root) {
    let smallest = null;

    function dfs(node, path) {
        if (!node) return;

        const char = String.fromCharCode(97 + node.val);
        path = char + path;

        if (!node.left && !node.right) {
            if (smallest === null || path < smallest) {
                smallest = path;
            }
            return;
        }

        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, '');
    return smallest;
};