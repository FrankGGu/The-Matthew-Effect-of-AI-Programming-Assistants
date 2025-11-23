class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(0);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            if (this.rank[rootI] < this.rank[rootJ]) {
                this.parent[rootI] = rootJ;
            } else if (this.rank[rootI] > this.rank[rootJ]) {
                this.parent[rootJ] = rootI;
            } else {
                this.parent[rootJ] = rootI;
                this.rank[rootI]++;
            }
            return true;
        }
        return false;
    }
}

function solvePropertiesGraph(items) {
    if (!items || items.length === 0) {
        return [];
    }

    const n = items.length;
    const dsu = new DSU(n);
    const propertyToItemIndices = new Map();

    for (let i = 0; i < n; i++) {
        const item = items[i];
        for (const prop of item.properties) {
            if (!propertyToItemIndices.has(prop)) {
                propertyToItemIndices.set(prop, []);
            }
            propertyToItemIndices.get(prop).push(i);
        }
    }

    for (const indices of propertyToItemIndices.values()) {
        if (indices.length > 1) {
            const firstIndex = indices[0];
            for (let k = 1; k < indices.length; k++) {
                dsu.union(firstIndex, indices[k]);
            }
        }
    }

    const groups = new Map();
    for (let i = 0; i < n; i++) {
        const root = dsu.find(i);
        if (!groups.has(root)) {
            groups.set(root, []);
        }
        groups.get(root).push(items[i].id);
    }

    return Array.from(groups.values());
}