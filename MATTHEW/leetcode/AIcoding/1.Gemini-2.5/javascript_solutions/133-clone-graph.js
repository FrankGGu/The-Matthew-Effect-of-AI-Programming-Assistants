var cloneGraph = function(node) {
    if (!node) {
        return null;
    }

    const visited = new Map();

    function dfs(originalNode) {
        if (visited.has(originalNode)) {
            return visited.get(originalNode);
        }

        const cloneNode = new Node(originalNode.val);
        visited.set(originalNode, cloneNode);

        for (const neighbor of originalNode.neighbors) {
            cloneNode.neighbors.push(dfs(neighbor));
        }

        return cloneNode;
    }

    return dfs(node);
};