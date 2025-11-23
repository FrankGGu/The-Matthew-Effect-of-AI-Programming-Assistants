class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(0);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            if (this.rank[rootI] < this.rank[rootJ]) {
                [rootI, rootJ] = [rootJ, rootI];
            }
            this.parent[rootJ] = rootI;
            if (this.rank[rootI] === this.rank[rootJ]) {
                this.rank[rootI]++;
            }
            return true;
        }
        return false;
    }
}

var numberOfGoodPaths = function(vals, edges) {
    const n = vals.length;
    const dsu = new DSU(n);
    let ans = n;

    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const nodesByValue = new Map();
    for (let i = 0; i < n; i++) {
        if (!nodesByValue.has(vals[i])) {
            nodesByValue.set(vals[i], []);
        }
        nodesByValue.get(vals[i]).push(i);
    }

    const sortedValues = Array.from(nodesByValue.keys()).sort((a, b) => a - b);

    for (const currentValue of sortedValues) {
        for (const node of nodesByValue.get(currentValue)) {
            for (const neighbor of adj[node]) {
                if (vals[neighbor] <= currentValue) {
                    dsu.union(node, neighbor);
                }
            }
        }

        const counts = new Map();
        for (const node of nodesByValue.get(currentValue)) {
            const root = dsu.find(node);
            counts.set(root, (counts.get(root) || 0) + 1);
        }

        for (const count of counts.values()) {
            ans += count * (count - 1) / 2;
        }
    }

    return ans;
};