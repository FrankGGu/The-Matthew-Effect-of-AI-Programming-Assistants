var treeQueries = function(root, queries) {
    const heightMap = new Map();
    const depthMap = new Map();
    const nodeMap = new Map();
    let maxDepth = 0;

    function dfs(node, depth) {
        if (!node) return 0;
        depthMap.set(node.val, depth);
        nodeMap.set(node.val, node);
        const leftHeight = dfs(node.left, depth + 1);
        const rightHeight = dfs(node.right, depth + 1);
        const height = Math.max(leftHeight, rightHeight) + 1;
        heightMap.set(node.val, height);
        return height;
    }

    dfs(root, 0);

    const cousins = new Map();
    const queue = [root];
    while (queue.length) {
        const levelSize = queue.length;
        const currentLevel = [];
        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentLevel.push(node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
        for (const val of currentLevel) {
            cousins.set(val, currentLevel.filter(v => v !== val));
        }
    }

    const result = [];
    for (const query of queries) {
        const nodeVal = query;
        const nodeDepth = depthMap.get(nodeVal);
        const siblings = cousins.get(nodeVal);
        let maxHeight = 0;
        for (const sibling of siblings) {
            if (depthMap.get(sibling) === nodeDepth) {
                const siblingHeight = heightMap.get(sibling) + depthMap.get(sibling);
                if (siblingHeight > maxHeight) {
                    maxHeight = siblingHeight;
                }
            }
        }
        const parentHeight = nodeDepth > 0 ? (nodeDepth - 1) : 0;
        const currentMax = Math.max(maxHeight, parentHeight);
        result.push(currentMax);
    }

    return result;
};