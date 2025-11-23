function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var maxDepth = function(root) {
    if (root === null) {
        return 0;
    }
    const leftDepth = maxDepth(root.left);
    const rightDepth = maxDepth(root.right);
    return Math.max(leftDepth, rightDepth) + 1;
};