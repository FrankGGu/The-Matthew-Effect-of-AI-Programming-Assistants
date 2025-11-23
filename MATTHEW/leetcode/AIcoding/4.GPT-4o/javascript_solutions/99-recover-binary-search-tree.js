var recoverTree = function(root) {
    let first = null, second = null, prev = null;

    const inorder = (node) => {
        if (!node) return;
        inorder(node.left);
        if (prev && prev.val > node.val) {
            if (!first) first = prev;
            second = node;
        }
        prev = node;
        inorder(node.right);
    };

    inorder(root);
    [first.val, second.val] = [second.val, first.val];
};