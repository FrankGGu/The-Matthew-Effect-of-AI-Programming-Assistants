var increasingBST = function(root) {
    let newRoot = null;
    let prev = null;

    function inorderTraversal(node) {
        if (!node) {
            return;
        }

        inorderTraversal(node.left);

        if (!newRoot) {
            newRoot = node;
        } else {
            prev.right = node;
        }
        node.left = null;
        prev = node;

        inorderTraversal(node.right);
    }

    inorderTraversal(root);
    return newRoot;
};