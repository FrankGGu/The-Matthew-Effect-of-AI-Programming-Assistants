var recoverTree = function(root) {
    let first = null;
    let second = null;
    let prev = null;

    function inorder(node) {
        if (!node) {
            return;
        }

        inorder(node.left);

        if (prev && prev.val > node.val) {
            if (!first) {
                first = prev;
            }
            second = node;
        }
        prev = node;

        inorder(node.right);
    }

    inorder(root);

    if (first && second) {
        let temp = first.val;
        first.val = second.val;
        second.val = temp;
    }
};