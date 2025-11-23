function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

function mergeTrees(root1, root2) {
    if (!root1 && !root2) return null;
    const val = (root1 ? root1.val : 0) + (root2 ? root2.val : 0);
    const left = mergeTrees(root1 ? root1.left : null, root2 ? root2.left : null);
    const right = mergeTrees(root1 ? root1.right : null, root2 ? root2.right : null);
    return new TreeNode(val, left, right);
}