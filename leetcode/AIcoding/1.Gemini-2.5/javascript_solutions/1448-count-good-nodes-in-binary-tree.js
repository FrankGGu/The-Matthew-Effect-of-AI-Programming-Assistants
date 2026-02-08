var goodNodes = function(root) {
    function dfs(node, maxValPath) {
        if (!node) {
            return 0;
        }

        let currentGoodNodes = 0;
        if (node.val >= maxValPath) {
            currentGoodNodes = 1;
        }

        const newMaxValPath = Math.max(maxValPath, node.val);

        currentGoodNodes += dfs(node.left, newMaxValPath);
        currentGoodNodes += dfs(node.right, newMaxValPath);

        return currentGoodNodes;
    }

    return dfs(root, -Infinity);
};