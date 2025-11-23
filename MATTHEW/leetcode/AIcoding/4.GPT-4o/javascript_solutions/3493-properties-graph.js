class PropertiesGraph {
    constructor() {
        this.graph = new Map();
    }

    addEdge(node1, node2) {
        if (!this.graph.has(node1)) this.graph.set(node1, new Set());
        if (!this.graph.has(node2)) this.graph.set(node2, new Set());
        this.graph.get(node1).add(node2);
        this.graph.get(node2).add(node1);
    }

    findProperties(connections) {
        for (const [node1, node2] of connections) {
            this.addEdge(node1, node2);
        }
    }

    isConnected(node1, node2) {
        const visited = new Set();
        const dfs = (node) => {
            if (node === node2) return true;
            visited.add(node);
            for (const neighbor of this.graph.get(node) || []) {
                if (!visited.has(neighbor) && dfs(neighbor)) return true;
            }
            return false;
        };
        return dfs(node1);
    }
}