class UnionFind {
    constructor(size) {
        this.parent = new Array(size);
        for (let i = 0; i < size; i++) {
            this.parent[i] = i;
        }
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

var friendRequests = function(n, restrictions, requests) {
    const uf = new UnionFind(n);
    const result = [];

    for (const [u, v] of requests) {
        const rootU = uf.find(u);
        const rootV = uf.find(v);
        let canBeFriends = true;

        for (const [a, b] of restrictions) {
            const rootA = uf.find(a);
            const rootB = uf.find(b);
            if ((rootA === rootU && rootB === rootV) || (rootA === rootV && rootB === rootU)) {
                canBeFriends = false;
                break;
            }
        }

        if (canBeFriends) {
            uf.union(u, v);
            result.push(true);
        } else {
            result.push(false);
        }
    }

    return result;
};