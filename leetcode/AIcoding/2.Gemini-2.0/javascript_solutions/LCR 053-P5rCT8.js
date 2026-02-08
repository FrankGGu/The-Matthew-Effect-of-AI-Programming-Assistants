var inorderSuccessor = function(root, p) {
    let successor = null;
    while (root) {
        if (p.val >= root.val) {
            root = root.right;
        } else {
            successor = root;
            root = root.left;
        }
    }
    return successor;
};