var binaryTreePaths = function(root) {
    const paths = [];

    function dfs(node, currentPath) {
        if (!node) {
            return;
        }

        currentPath.push(node.val);

        if (!node.left && !node.right) {
            paths.push(currentPath.join("->"));
            return;
        }

        if (node.left) {
            dfs(node.left, [...currentPath]);
        }
        if (node.right) {
            dfs(node.right, [...currentPath]);
        }
    }

    if (!root) {
        return [];
    }

    dfs(root, []);
    return paths;
};