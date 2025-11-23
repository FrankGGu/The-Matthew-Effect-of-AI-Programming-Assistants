function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var recoverTree = function(root) {
    let first = null;
    let second = null;
    let prev = new TreeNode(-Infinity);

    const inorder = function(node) {
        if (!node) return;
        inorder(node.left);
        if (prev.val > node.val) {
            if (!first) first = prev;
            second = node;
        }
        prev = node;
        inorder(node.right);
    };

    inorder(root);
    [first.val, second.val] = [second.val, first.val];
};