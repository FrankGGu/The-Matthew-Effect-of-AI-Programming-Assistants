var countPathsWithXOR = function(root, target) {
    let count = 0;
    const prefixCount = new Map();
    prefixCount.set(0, 1);

    function dfs(node, currentXOR) {
        if (!node) return;

        currentXOR ^= node.val;

        count += prefixCount.get(currentXOR ^ target) || 0;

        prefixCount.set(currentXOR, (prefixCount.get(currentXOR) || 0) + 1);

        dfs(node.left, currentXOR);
        dfs(node.right, currentXOR);

        prefixCount.set(currentXOR, prefixCount.get(currentXOR) - 1);
    }

    dfs(root, 0);
    return count;
};