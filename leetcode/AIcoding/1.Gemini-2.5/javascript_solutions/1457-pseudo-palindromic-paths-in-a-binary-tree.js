var pseudoPalindromicPaths = function(root) {
    let count = 0;

    function dfs(node, pathMask) {
        if (!node) {
            return;
        }

        pathMask ^= (1 << (node.val - 1));

        if (!node.left && !node.right) {
            if ((pathMask & (pathMask - 1)) === 0) {
                count++;
            }
            return;
        }

        dfs(node.left, pathMask);
        dfs(node.right, pathMask);
    }

    dfs(root, 0);
    return count;
};