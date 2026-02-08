var TreeAncestor = function(n, parent) {
    this.LOG = 17; // ceil(log2(50000)) is 16, so 17 is a safe upper bound for powers of 2
    this.up = Array(n).fill(0).map(() => Array(this.LOG).fill(-1));

    for (let i = 0; i < n; i++) {
        this.up[i][0] = parent[i];
    }

    for (let j = 1; j < this.LOG; j++) {
        for (let i = 0; i < n; i++) {
            if (this.up[i][j - 1] !== -1) {
                this.up[i][j] = this.up[this.up[i][j - 1]][j - 1];
            }
        }
    }
};

TreeAncestor.prototype.getKthAncestor = function(node, k) {
    for (let j = this.LOG - 1; j >= 0; j--) {
        if ((k >> j) & 1) { // If the j-th bit of k is set
            if (node === -1) { // Already reached above root
                return -1;
            }
            node = this.up[node][j];
        }
    }
    return node;
};