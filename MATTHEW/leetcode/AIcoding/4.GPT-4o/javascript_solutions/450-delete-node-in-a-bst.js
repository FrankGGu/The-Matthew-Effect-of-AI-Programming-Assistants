class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var deleteNode = function(root, key) {
    if (!root) return null;
    if (key < root.val) {
        root.left = deleteNode(root.left, key);
    } else if (key > root.val) {
        root.right = deleteNode(root.right, key);
    } else {
        if (!root.left) return root.right;
        if (!root.right) return root.left;
        let minNode = root.right;
        while (minNode.left) {
            minNode = minNode.left;
        }
        root.val = minNode.val;
        root.right = deleteNode(root.right, minNode.val);
    }
    return root;
};