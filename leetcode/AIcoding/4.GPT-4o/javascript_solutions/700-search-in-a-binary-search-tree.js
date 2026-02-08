class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var searchBST = function(root, val) {
    if (root === null) {
        return null;
    }
    if (root.val === val) {
        return root;
    }
    return val < root.val ? searchBST(root.left, val) : searchBST(root.right, val);
};