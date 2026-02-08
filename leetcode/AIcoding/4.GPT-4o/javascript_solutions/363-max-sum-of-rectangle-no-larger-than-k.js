class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = this.right = null;
    }
}

class SegmentTree {
    constructor() {
        this.root = null;
    }

    insert(val) {
        this.root = this._insert(this.root, val);
    }

    _insert(node, val) {
        if (!node) return new TreeNode(val);
        if (val < node.val) {
            node.left = this._insert(node.left, val);
        } else {
            node.right = this._insert(node.right, val);
        }
        return node;
    }

    maxLessEqual(node, val) {
        let max = -Infinity;
        while (node) {
            if (node.val <= val) {
                max = Math.max(max, node.val);
                node = node.right;
            } else {
                node = node.left;
            }
        }
        return max;
    }
}

var maxSumSubmatrix = function(matrix, k) {
    if (!matrix.length || !matrix[0].length) return 0;
    const m = matrix.length, n = matrix[0].length;
    let maxSum = -Infinity;

    for (let left = 0; left < n; left++) {
        const sums = new Array(m).fill(0);
        for (let right = left; right < n; right++) {
            for (let i = 0; i < m; i++) {
                sums[i] += matrix[i][right];
            }
            const tree = new SegmentTree();
            tree.insert(0);
            let currSum = 0;
            for (const sum of sums) {
                currSum += sum;
                const target = currSum - k;
                const maxVal = tree.maxLessEqual(tree.root, target);
                if (maxVal !== -Infinity) {
                    maxSum = Math.max(maxSum, currSum - maxVal);
                }
                tree.insert(currSum);
            }
        }
    }
    return maxSum;
};