var maxScoreSubarray = function(nums, queries) {
    const n = nums.length;
    const q = queries.length;
    const sortedQueries = queries.map((query, index) => [query[0], query[1], index]).sort((a, b) => b[0] - a[0]);
    const sortedNums = nums.map((num, index) => [num, index]).sort((a, b) => b[0] - a[0]);
    const uf = new UnionFind(n);
    const scores = new Array(n).fill(0);
    let numIndex = 0;
    const res = new Array(q);

    for (const [k, x, index] of sortedQueries) {
        while (numIndex < n && sortedNums[numIndex][0] >= k) {
            const num = sortedNums[numIndex][0];
            const i = sortedNums[numIndex][1];
            scores[i] = num;

            if (i > 0 && scores[i - 1] > 0) {
                uf.union(i, i - 1);
            }
            if (i < n - 1 && scores[i + 1] > 0) {
                uf.union(i, i + 1);
            }

            numIndex++;
        }

        res[index] = scores[x];
    }

    return res;

    function UnionFind(n) {
        this.parent = new Array(n);
        this.size = new Array(n).fill(1);

        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }

        this.find = function(x) {
            if (this.parent[x] !== x) {
                this.parent[x] = this.find(this.parent[x]);
            }
            return this.parent[x];
        }

        this.union = function(x, y) {
            const rootX = this.find(x);
            const rootY = this.find(y);

            if (rootX !== rootY) {
                if (this.size[rootX] < this.size[rootY]) {
                    this.parent[rootX] = rootY;
                    this.size[rootY] += this.size[rootX];
                } else {
                    this.parent[rootY] = rootX;
                    this.size[rootX] += this.size[rootY];
                }
            }
        }
    }
};