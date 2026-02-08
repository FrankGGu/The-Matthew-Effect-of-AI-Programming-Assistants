var inorderSuccessor = function(root, p) {
    let successor = null;

    while (root !== null) {
        if (p.val < root.val) {
            successor = root;
            root = root.left;
        } else {
            root = root.right;
        }
    }

    return successor;
};