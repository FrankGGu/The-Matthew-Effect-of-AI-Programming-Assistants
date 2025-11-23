function findTarget(root, target) {
    const set = new Set();

    function dfs(node) {
        if (!node) return false;
        if (set.has(target - node.val)) return true;
        set.add(node.val);
        return dfs(node.left) || dfs(node.right);
    }

    return dfs(root);
}