function createComponentsWithSameValue(root) {
    const map = new Map();

    function dfs(node) {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);

        const sum = node.val + left + right;
        const count = map.get(sum) || 0;
        map.set(sum, count + 1);

        return sum;
    }

    dfs(root);

    let maxCount = 0;
    for (const count of map.values()) {
        if (count > maxCount) {
            maxCount = count;
        }
    }

    return maxCount;
}