var smallestFromLeaf = function(root) {
    let smallestString = "";

    function dfs(node, currentPath) {
        if (!node) {
            return;
        }

        const char = String.fromCharCode(97 + node.val);
        const newPath = char + currentPath;

        if (!node.left && !node.right) {
            if (smallestString === "" || newPath < smallestString) {
                smallestString = newPath;
            }
            return;
        }

        dfs(node.left, newPath);
        dfs(node.right, newPath);
    }

    dfs(root, "");
    return smallestString;
};