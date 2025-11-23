var treeQueries = function(root, queries) {
    const depth = new Map();
    const height = new Map();
    const parent = new Map();

    function dfs(node, dep, par) {
        if (!node) return -1;
        depth.set(node, dep);
        parent.set(node, par);
        const leftHeight = dfs(node.left, dep + 1, node);
        const rightHeight = dfs(node.right, dep + 1, node);
        height.set(node, Math.max(leftHeight, rightHeight) + 1);
        return height.get(node);
    }

    dfs(root, 0, null);

    const result = [];
    for (const query of queries) {
        let node = findNode(root, query);
        let currentHeight = 0;
        let visited = new Set();
        visited.add(node);

        function findHeight(rootNode, ignoreNodes) {
            if (!rootNode || ignoreNodes.has(rootNode)) return -1;
            return Math.max(findHeight(rootNode.left, ignoreNodes), findHeight(rootNode.right, ignoreNodes)) + 1;
        }

        let currentParent = parent.get(node);
        while (currentParent) {
            visited.add(node);
            let sibling = null;
            if (currentParent.left === node) {
                sibling = currentParent.right;
            } else {
                sibling = currentParent.left;
            }

            let siblingHeight = findHeight(sibling, visited);
            currentHeight = Math.max(currentHeight, siblingHeight + depth.get(currentParent) + 1);
            node = currentParent;
            currentParent = parent.get(node);
        }

        result.push(currentHeight);
    }

    function findNode(rootNode, target) {
        if (!rootNode) return null;
        if (rootNode.val === target) return rootNode;
        const leftResult = findNode(rootNode.left, target);
        if (leftResult) return leftResult;
        return findNode(rootNode.right, target);
    }

    return result;
};