var binaryTreePaths = function(root) {
    const paths = [];
    const constructPaths = (node, path) => {
        if (node) {
            path += node.val;
            if (!node.left && !node.right) {
                paths.push(path);
            } else {
                path += '->';
                constructPaths(node.left, path);
                constructPaths(node.right, path);
            }
        }
    };
    constructPaths(root, '');
    return paths;
};