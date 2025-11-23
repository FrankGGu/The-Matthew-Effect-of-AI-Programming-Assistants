class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var insertIntoMaxTree = function(root, val) {
    if (!root || val > root.val) {
        return new TreeNode(val, root);
    }
    root.right = insertIntoMaxTree(root.right, val);
    return root;
};