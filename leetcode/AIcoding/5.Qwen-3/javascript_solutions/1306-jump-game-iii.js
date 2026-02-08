function canReach(head, idx) {
    const visited = new Set();

    function dfs(node, index) {
        if (index < 0 || index >= node.length || visited.has(index)) return false;
        if (node[index] === 0) return true;
        visited.add(index);
        return dfs(node, index + node[index]) || dfs(node, index - node[index]);
    }

    return dfs(head, idx);
}