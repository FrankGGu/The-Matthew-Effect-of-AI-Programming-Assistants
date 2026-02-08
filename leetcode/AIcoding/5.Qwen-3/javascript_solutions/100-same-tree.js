function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var isSameTree = function(p, q) {
    if (!p && !q) return true;
    if (!p || !q) return false;
    return p.val === q.val && isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
};