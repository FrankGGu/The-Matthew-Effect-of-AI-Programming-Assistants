var treeToDoublyList = function(root) {
    if (!root) return null;

    let head = null;
    let prev = null;

    function inorder(node) {
        if (!node) return;

        inorder(node.left);

        if (!head) {
            head = node;
        } else {
            prev.right = node;
            node.left = prev;
        }
        prev = node;

        inorder(node.right);
    }

    inorder(root);

    head.left = prev;
    prev.right = head;

    return head;
};