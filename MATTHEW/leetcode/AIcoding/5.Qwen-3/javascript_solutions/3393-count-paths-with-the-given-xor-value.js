function countPaths(root, target) {
    const map = new Map();
    map.set(0, 1);
    let result = 0;

    function dfs(node, currentXOR) {
        if (!node) return;
        currentXOR ^= node.val;
        if (map.has(currentXOR ^ target)) {
            result += map.get(currentXOR ^ target);
        }
        map.set(currentXOR, (map.get(currentXOR) || 0) + 1);
        dfs(node.left, currentXOR);
        dfs(node.right, currentXOR);
        map.set(currentXOR, map.get(currentXOR) - 1);
    }

    dfs(root, 0);
    return result;
}