class TreeNode {
    constructor(val, left, right) {
        this.val = val === undefined ? 0 : val;
        this.left = left === undefined ? null : left;
        this.right = right === undefined ? null : right;
    }
}

var sumOfLeftLeaves = function(root) {
    if (!root) return 0;
    let sum = 0;

    const traverse = (node, isLeft) => {
        if (!node) return;
        if (!node.left && !node.right && isLeft) {
            sum += node.val;
        }
        traverse(node.left, true);
        traverse(node.right, false);
    };

    traverse(root, false);
    return sum;
};