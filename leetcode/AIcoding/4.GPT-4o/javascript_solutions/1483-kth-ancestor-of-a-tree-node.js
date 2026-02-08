class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = this.right = null;
    }
}

class TreeAncestor {
    constructor(n, parent) {
        this.ancestor = Array.from({ length: n }, () => new Array(16).fill(-1));
        for (let i = 0; i < n; i++) {
            this.ancestor[i][0] = parent[i];
        }
        for (let j = 1; j < 16; j++) {
            for (let i = 0; i < n; i++) {
                if (this.ancestor[i][j - 1] !== -1) {
                    this.ancestor[i][j] = this.ancestor[this.ancestor[i][j - 1]][j - 1];
                }
            }
        }
    }

    getKthAncestor(node, k) {
        for (let j = 0; j < 16; j++) {
            if (k & (1 << j)) {
                node = this.ancestor[node][j];
                if (node === -1) return -1;
            }
        }
        return node;
    }
}