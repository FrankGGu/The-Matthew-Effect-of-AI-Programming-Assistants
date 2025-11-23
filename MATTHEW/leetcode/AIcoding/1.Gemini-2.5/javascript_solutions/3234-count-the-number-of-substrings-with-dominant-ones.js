class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0);
        this.size = size;
    }

    update(idx, delta) {
        idx++;
        while (idx <= this.size) {
            this.tree[idx] += delta;
            idx += idx & (-idx);
        }
    }

    query(idx) {
        idx++;
        let sum = 0;
        while (idx > 0) {
            sum += this.tree[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
}

var countSubstrings = function(s) {
    const n = s.length;
    let ans = 0;
    let currentBalance = 0;

    const offset = n;
    const fenwickTree = new FenwickTree(2 * n + 1);

    fenwickTree.update(0 + offset, 1);

    for (let j = 0; j < n; j++) {
        if (s[j] === '1') {
            currentBalance++;
        } else {
            currentBalance--;
        }

        ans += fenwickTree.query(currentBalance - 1 + offset);

        fenwickTree.update(currentBalance + offset, 1);
    }

    return ans;
};