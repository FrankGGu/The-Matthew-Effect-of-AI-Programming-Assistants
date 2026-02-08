class Node {
    constructor(val, neighbors) {
        this.val = val;
        this.neighbors = neighbors === undefined ? [] : neighbors;
    }
}

var cloneGraph = function(node) {
    if (!node) return null;

    const map = new Map();

    const dfs = (n) => {
        if (map.has(n)) return map.get(n);
        const clone = new Node(n.val);
        map.set(n, clone);
        for (const neighbor of n.neighbors) {
            clone.neighbors.push(dfs(neighbor));
        }
        return clone;
    };

    return dfs(node);
};