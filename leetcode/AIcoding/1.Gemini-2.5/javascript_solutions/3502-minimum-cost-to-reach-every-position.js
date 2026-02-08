class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(0);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
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

function minCostConnectPoints(points) {
    const n = points.length;
    if (n <= 1) {
        return 0;
    }

    const edges = [];
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const dist = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
            edges.push([dist, i, j]);
        }
    }

    edges.sort((a, b) => a[0] - b[0]);

    const dsu = new DSU(n);
    let minCost = 0;
    let edgesCount = 0;

    for (const [cost, u, v] of edges) {
        if (dsu.union(u, v)) {
            minCost += cost;
            edgesCount++;
            if (edgesCount === n - 1) {
                break;
            }
        }
    }

    return minCost;
}