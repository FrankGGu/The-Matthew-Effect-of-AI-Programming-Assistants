var distanceK = function(root, target, k) {
    const parentMap = new Map();
    const result = [];

    function buildParentMap(node, parent) {
        if (!node) return;
        parentMap.set(node, parent);
        buildParentMap(node.left, node);
        buildParentMap(node.right, node);
    }

    buildParentMap(root, null);

    function dfs(node, distance, visited) {
        if (!node || visited.has(node)) return;
        visited.add(node);
        if (distance === k) {
            result.push(node.val);
            return;
        }
        dfs(node.left, distance + 1, visited);
        dfs(node.right, distance + 1, visited);
        dfs(parentMap.get(node), distance + 1, visited);
    }

    dfs(target, 0, new Set());
    return result;
};