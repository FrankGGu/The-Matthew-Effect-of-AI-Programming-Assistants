class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(1);
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
            if (this.rank[rootX] > this.rank[rootY]) {
                this.parent[rootY] = rootX;
            } else if (this.rank[rootX] < this.rank[rootY]) {
                this.parent[rootX] = rootY;
            } else {
                this.parent[rootY] = rootX;
                this.rank[rootX]++;
            }
            return true;
        }
        return false;
    }
}

var minimizeMax = function(edges, n) {
    edges.sort((a, b) => a[2] - b[2]);

    let left = 0, right = Math.max(...edges.map(edge => edge[2]));

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        const uf = new UnionFind(n);
        let count = 0;

        for (const [u, v, w] of edges) {
            if (w <= mid && uf.union(u, v)) {
                count++;
            }
        }

        if (count === n - 1) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};