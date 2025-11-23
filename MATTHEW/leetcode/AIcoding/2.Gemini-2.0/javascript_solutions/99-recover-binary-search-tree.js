var recoverTree = function(root) {
    let first = null;
    let second = null;
    let prev = null;

    function inorder(node) {
        if (!node) return;

        inorder(node.left);

        if (prev !== null && node.val < prev.val) {
            if (first === null) {
                first = prev;
            }
            second = node;
        }

        prev = node;

        inorder(node.right);
    }

    inorder(root);

    let temp = first.val;
    first.val = second.val;
    second.val = temp;
};