var TreeAncestor = function(n, parent) {
    this.n = n;
    this.parent = parent;
    this.max_level = Math.floor(Math.log2(n)) + 1;
    this.dp = Array(n).fill(null).map(() => Array(this.max_level + 1).fill(-1));

    for (let i = 0; i < n; i++) {
        this.dp[i][0] = parent[i];
    }

    for (let j = 1; j <= this.max_level; j++) {
        for (let i = 0; i < n; i++) {
            if (this.dp[i][j - 1] != -1) {
                this.dp[i][j] = this.dp[this.dp[i][j - 1]][j - 1];
            }
        }
    }
};

TreeAncestor.prototype.getKthAncestor = function(node, k) {
    for (let i = 0; i <= this.max_level; i++) {
        if ((k >> i) & 1) {
            node = this.dp[node][i];
            if (node == -1) {
                return -1;
            }
        }
    }
    return node;
};