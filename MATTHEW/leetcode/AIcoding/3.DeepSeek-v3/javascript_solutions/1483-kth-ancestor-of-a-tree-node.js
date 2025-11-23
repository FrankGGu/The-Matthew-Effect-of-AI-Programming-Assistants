var TreeAncestor = function(n, parent) {
    this.log = Math.floor(Math.log2(n)) + 1;
    this.up = Array.from({ length: n }, () => new Array(this.log).fill(-1));

    for (let v = 0; v < n; v++) {
        this.up[v][0] = parent[v];
    }

    for (let j = 1; j < this.log; j++) {
        for (let v = 0; v < n; v++) {
            if (this.up[v][j-1] !== -1) {
                this.up[v][j] = this.up[this.up[v][j-1]][j-1];
            }
        }
    }
};

TreeAncestor.prototype.getKthAncestor = function(node, k) {
    for (let j = 0; j < this.log; j++) {
        if (k & (1 << j)) {
            node = this.up[node][j];
            if (node === -1) return -1;
        }
    }
    return node;
};