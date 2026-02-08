class UnionFind {
    constructor(size) {
        this.parent = Array.from({ length: size }, (_, i) => i);
        this.rank = Array(size).fill(1);
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
        }
    }
}

function largestComponentSize(A) {
    const max = Math.max(...A);
    const uf = new UnionFind(max + 1);

    const sieve = Array(max + 1).fill(false);
    for (let i = 2; i <= max; i++) {
        if (!sieve[i]) {
            for (let j = i; j <= max; j += i) {
                sieve[j] = true;
                if (A.includes(j)) {
                    uf.union(i, j);
                }
            }
        }
    }

    const count = {};
    for (const num of A) {
        const root = uf.find(num);
        count[root] = (count[root] || 0) + 1;
    }

    return Math.max(...Object.values(count));
}