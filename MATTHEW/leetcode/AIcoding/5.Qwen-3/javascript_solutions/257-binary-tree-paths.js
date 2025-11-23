function binaryTreePaths(root) {
    let result = [];

    function dfs(node, path) {
        if (!node) return;
        path += node.val;
        if (!node.left && !node.right) {
            result.push(path);
            return;
        }
        path += '->';
        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, '');
    return result;
}