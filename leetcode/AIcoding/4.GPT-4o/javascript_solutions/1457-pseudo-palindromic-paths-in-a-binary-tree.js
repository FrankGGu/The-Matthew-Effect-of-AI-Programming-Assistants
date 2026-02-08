var pseudoPalindromicPaths = function(root) {
    let count = 0;

    const dfs = (node, path) => {
        if (!node) return;
        path ^= (1 << node.val);
        if (!node.left && !node.right) {
            if ((path & (path - 1)) === 0) count++;
        } else {
            dfs(node.left, path);
            dfs(node.right, path);
        }
    };

    dfs(root, 0);
    return count;
};