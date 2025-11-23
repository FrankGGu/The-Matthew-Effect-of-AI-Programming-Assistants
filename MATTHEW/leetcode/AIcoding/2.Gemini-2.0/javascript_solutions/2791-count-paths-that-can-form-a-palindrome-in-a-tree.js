var pseudoPalindromicPaths  = function(root) {
    let count = 0;

    function dfs(node, path) {
        if (!node) return;

        path ^= (1 << node.val);

        if (!node.left && !node.right) {
            if ((path & (path - 1)) === 0) {
                count++;
            }
            return;
        }

        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, 0);
    return count;
};