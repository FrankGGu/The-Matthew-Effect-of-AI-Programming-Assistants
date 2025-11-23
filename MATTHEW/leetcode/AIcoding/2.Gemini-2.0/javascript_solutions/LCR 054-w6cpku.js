var convertBST = function(root) {
    let sum = 0;

    function inorder(node) {
        if (!node) return;

        inorder(node.right);
        sum += node.val;
        node.val = sum;
        inorder(node.left);
    }

    inorder(root);
    return root;
};