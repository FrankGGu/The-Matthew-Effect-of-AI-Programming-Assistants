var smallestStringWithSwaps = function(s, pairs) {
    const uf = new UnionFind(s.length);

    for (const [a, b] of pairs) {
        uf.union(a, b);
    }

    const components = {};

    for (let i = 0; i < s.length; i++) {
        const root = uf.find(i);
        if (!components[root]) {
            components[root] = [];
        }
        components[root].push(s[i]);
    }

    for (const key in components) {
        components[key].sort();
    }

    const result = [];

    for (let i = 0; i < s.length; i++) {
        const root = uf.find(i);
        result.push(components[root].shift());
    }

    return result.join('');
};

class UnionFind {
    constructor(size) {
        this.parent = Array.from({length: size}, (_, i) => i);
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);
        if (rootX !== rootY) {
            this.parent[rootY] = rootX;
        }
    }
}