class DSU {
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
            this.parent[rootJ] = rootI;
            return true;
        }
        return false;
    }
}

var smallestStringWithSwaps = function(s, pairs) {
    const n = s.length;
    const dsu = new DSU(n);

    for (const [u, v] of pairs) {
        dsu.union(u, v);
    }

    const components = new Map(); 

    for (let i = 0; i < n; i++) {
        const root = dsu.find(i);
        if (!components.has(root)) {
            components.set(root, { chars: [], indices: [] });
        }
        components.get(root).chars.push(s[i]);
        components.get(root).indices.push(i);
    }

    const result = new Array(n);

    for (const [root, data] of components.entries()) {
        const chars = data.chars.sort(); 
        const indices = data.indices.sort((a, b) => a - b); 

        for (let i = 0; i < chars.length; i++) {
            result[indices[i]] = chars[i];
        }
    }

    return result.join('');
};