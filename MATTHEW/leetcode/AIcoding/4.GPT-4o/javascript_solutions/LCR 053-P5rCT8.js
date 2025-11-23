function inorderSuccessor(root, p) {
    let successor = null;
    while (root) {
        if (p.val < root.val) {
            successor = root;
            root = root.left;
        } else {
            root = root.right;
        }
    }
    return successor;
}