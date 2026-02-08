var subtreeWithAllDeepest = function(root) {
    function dfs(node) {
        if (!node) return { depth: 0, subtree: null };
        const left = dfs(node.left);
        const right = dfs(node.right);
        if (left.depth > right.depth) {
            return { depth: left.depth + 1, subtree: left.subtree };
        } else if (left.depth < right.depth) {
            return { depth: right.depth + 1, subtree: right.subtree };
        } else {
            return { depth: left.depth + 1, subtree: node };
        }
    }
    return dfs(root).subtree;
};