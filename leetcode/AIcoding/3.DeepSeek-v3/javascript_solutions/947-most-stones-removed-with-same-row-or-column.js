class UnionFind {
    constructor() {
        this.parent = {};
        this.count = 0;
    }

    find(x) {
        if (this.parent[x] === undefined) {
            this.parent[x] = x;
            this.count++;
        }
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);
        if (rootX === rootY) return;
        this.parent[rootX] = rootY;
        this.count--;
    }
}

var removeStones = function(stones) {
    const uf = new UnionFind();
    for (const [x, y] of stones) {
        uf.union(x, ~y);
    }
    return stones.length - uf.count;
};