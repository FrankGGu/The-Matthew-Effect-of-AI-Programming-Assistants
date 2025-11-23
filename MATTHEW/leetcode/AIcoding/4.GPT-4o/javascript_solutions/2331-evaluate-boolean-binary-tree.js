class TreeNode {
    constructor(val, left, right) {
        this.val = val === undefined ? 0 : val;
        this.left = left === undefined ? null : left;
        this.right = right === undefined ? null : right;
    }
}

var evaluateTree = function(root) {
    if (root.val === 0) return false;
    if (root.val === 1) return true;
    const leftEval = evaluateTree(root.left);
    const rightEval = evaluateTree(root.right);
    return root.val === 2 ? leftEval || rightEval : leftEval && rightEval;
};