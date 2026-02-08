var binaryTreePaths = function(root) {
    const paths = [];
    if (!root) return paths;

    function dfs(node, path) {
        if (!node.left && !node.right) {
            paths.push(path + node.val);
            return;
        }
        if (node.left) {
            dfs(node.left, path + node.val + "->");
        }
        if (node.right) {
            dfs(node.right, path + node.val + "->");
        }
    }

    dfs(root, "");
    return paths;
};