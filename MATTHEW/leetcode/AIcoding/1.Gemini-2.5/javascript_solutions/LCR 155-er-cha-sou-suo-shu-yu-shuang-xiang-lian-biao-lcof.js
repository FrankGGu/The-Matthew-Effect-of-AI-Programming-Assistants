var treeToDoublyList = function(root) {
    if (!root) {
        return null;
    }

    let head = null;
    let tail = null;

    function inorder(node) {
        if (!node) {
            return;
        }

        inorder(node.left);

        if (!head) {
            head = node;
            tail = node;
        } else {
            tail.right = node;
            node.left = tail;
            tail = node;
        }

        inorder(node.right);
    }

    inorder(root);

    head.left = tail;
    tail.right = head;

    return head;
};