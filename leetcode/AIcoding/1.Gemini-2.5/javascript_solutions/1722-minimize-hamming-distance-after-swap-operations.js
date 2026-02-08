class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ;
            return true;
        }
        return false;
    }
}

var minHammingDistance = function(source, target, allowedSwaps) {
    const n = source.length;
    const uf = new UnionFind(n);

    for (const [a, b] of allowedSwaps) {
        uf.union(a, b);
    }

    const components = new Map(); // Map<root_idx, { source_counts: Map<number, number>, target_counts: Map<number, number> }>

    for (let i = 0; i < n; i++) {
        const root = uf.find(i);
        if (!components.has(root)) {
            components.set(root, {
                source_counts: new Map(),
                target_counts: new Map()
            });
        }
        const componentData = components.get(root);

        componentData.source_counts.set(source[i], (componentData.source_counts.get(source[i]) || 0) + 1);
        componentData.target_counts.set(target[i], (componentData.target_counts.get(target[i]) || 0) + 1);
    }

    let hammingDistance = 0;

    for (const [root, data] of components.entries()) {
        const { source_counts, target_counts } = data;
        let matchesInComponent = 0;
        let componentSize = 0; 

        for (const [num, s_count] of source_counts.entries()) {
            const t_count = target_counts.get(num) || 0;
            matchesInComponent += Math.min(s_count, t_count);
            componentSize += s_count; 
        }

        hammingDistance += (componentSize - matchesInComponent);
    }

    return hammingDistance;
};