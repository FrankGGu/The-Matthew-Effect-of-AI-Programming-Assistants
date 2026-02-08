var inorderSuccessor = function(root, p) {
    let successor = null;
    while (root !== null) {
        if (root.val > p.val) {
            successor = root;
            root = root.left;
        } else {
            root = root.right;
        }
    }
    return successor;
};