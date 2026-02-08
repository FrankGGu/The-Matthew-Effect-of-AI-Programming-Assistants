var flatten = function(root) {
    let prev = null;

    function flattenTree(node) {
        if (!node) return;
        flattenTree(node.right);
        flattenTree(node.left);
        node.right = prev;
        node.left = null;
        prev = node;
    }

    flattenTree(root);
};