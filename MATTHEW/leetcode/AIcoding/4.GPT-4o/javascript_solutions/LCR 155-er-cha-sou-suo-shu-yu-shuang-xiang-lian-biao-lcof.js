class Node {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var treeToDoublyList = function(root) {
    if (!root) return null;

    let head = null, prev = null;

    const inOrder = (node) => {
        if (!node) return;
        inOrder(node.left);
        if (!head) {
            head = node;
        }
        if (prev) {
            prev.right = node;
            node.left = prev;
        }
        prev = node;
        inOrder(node.right);
    };

    inOrder(root);
    head.left = prev;
    prev.right = head;

    return head;
};