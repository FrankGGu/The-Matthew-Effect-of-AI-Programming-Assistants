class UnionFind {
    constructor(size) {
        this.parent = Array.from({ length: size }, (_, i) => i);
        this.rank = new Array(size).fill(0);
    }

    find(u) {
        if (this.parent[u] !== u) {
            this.parent[u] = this.find(this.parent[u]);
        }
        return this.parent[u];
    }

    union(u, v) {
        let rootU = this.find(u);
        let rootV = this.find(v);
        if (rootU === rootV) return false;
        if (this.rank[rootU] > this.rank[rootV]) {
            this.parent[rootV] = rootU;
        } else if (this.rank[rootU] < this.rank[rootV]) {
            this.parent[rootU] = rootV;
        } else {
            this.parent[rootV] = rootU;
            this.rank[rootU]++;
        }
        return true;
    }
}

class DistanceLimitedPathsExist {
    constructor(n, edgeList) {
        this.ufs = [];
        edgeList.sort((a, b) => a[2] - b[2]);
        this.edges = edgeList;
        this.buildUFS();
    }

    buildUFS() {
        let edgeList = this.edges;
        let uf = new UnionFind(edgeList.length + 1);
        let prevLimit = 0;
        for (let edge of edgeList) {
            let [u, v, limit] = edge;
            if (limit > prevLimit) {
                this.ufs.push([prevLimit, new UnionFind(uf.parent.length)]);
                this.copyUF(uf, this.ufs[this.ufs.length - 1][1]);
                prevLimit = limit;
            }
            uf.union(u, v);
        }
        this.ufs.push([prevLimit, uf]);
    }

    copyUF(source, target) {
        for (let i = 0; i < source.parent.length; i++) {
            target.parent[i] = source.parent[i];
            target.rank[i] = source.rank[i];
        }
    }

    query(p, q, limit) {
        let left = 0, right = this.ufs.length - 1;
        let bestUF = null;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (this.ufs[mid][0] < limit) {
                bestUF = this.ufs[mid][1];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        if (!bestUF) return false;
        return bestUF.find(p) === bestUF.find(q);
    }
}