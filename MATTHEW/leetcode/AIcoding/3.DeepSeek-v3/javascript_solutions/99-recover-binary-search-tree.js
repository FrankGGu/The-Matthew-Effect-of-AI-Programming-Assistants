var recoverTree = function(root) {
    let first = null, second = null, prev = new TreeNode(-Infinity);

    function inorder(node) {
        if (!node) return;

        inorder(node.left);

        if (prev.val >= node.val) {
            if (!first) first = prev;
            second = node;
        }
        prev = node;

        inorder(node.right);
    }

    inorder(root);

    [first.val, second.val] = [second.val, first.val];
};