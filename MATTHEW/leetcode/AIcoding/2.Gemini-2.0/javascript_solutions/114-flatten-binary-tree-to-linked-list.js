var flatten = function(root) {
    let prev = null;

    function traverse(node) {
        if (!node) return;

        traverse(node.right);
        traverse(node.left);

        node.right = prev;
        node.left = null;
        prev = node;
    }

    traverse(root);
};