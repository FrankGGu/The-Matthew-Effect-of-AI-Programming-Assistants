var treeToDoublyList = function(root) {
    if (!root) return null;
    let first = null;
    let last = null;

    const inorder = function(node) {
        if (!node) return;
        inorder(node.left);
        if (last) {
            last.right = node;
            node.left = last;
        } else {
            first = node;
        }
        last = node;
        inorder(node.right);
    };

    inorder(root);
    first.left = last;
    last.right = first;
    return first;
};