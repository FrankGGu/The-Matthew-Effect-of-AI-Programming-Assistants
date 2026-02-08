function removeMaxEdges(n, edges) {
    function find(parent, x) {
        if (parent[x] !== x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    function union(parent, rank, x, y) {
        const rootX = find(parent, x);
        const rootY = find(parent, y);
        if (rootX === rootY) return false;
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            if (rank[rootX] === rank[rootY]) {
                rank[rootY]++;
            }
        }
        return true;
    }

    let count = 0;

    const parent1 = Array.from({ length: n + 1 }, (_, i) => i);
    const rank1 = Array(n + 1).fill(0);

    const parent2 = Array.from({ length: n + 1 }, (_, i) => i);
    const rank2 = Array(n + 1).fill(0);

    for (const [type, u, v] of edges) {
        if (type === 2) {
            if (find(parent1, u) !== find(parent1, v)) {
                union(parent1, rank1, u, v);
                union(parent2, rank2, u, v);
                count++;
            }
        }
    }

    for (const [type, u, v] of edges) {
        if (type === 1) {
            if (find(parent1, u) !== find(parent1, v)) {
                union(parent1, rank1, u, v);
                count++;
            }
        }
    }

    for (const [type, u, v] of edges) {
        if (type === 2) {
            if (find(parent2, u) !== find(parent2, v)) {
                union(parent2, rank2, u, v);
                count++;
            }
        }
    }

    const root1 = find(parent1, 1);
    const root2 = find(parent2, 1);

    for (let i = 2; i <= n; i++) {
        if (find(parent1, i) !== root1 || find(parent2, i) !== root2) {
            return -1;
        }
    }

    return edges.length - count;
}