var convertBST = function(root) {
    let sum = 0;

    function traverse(node) {
        if (!node) return;

        traverse(node.right);

        sum += node.val;
        node.val = sum;

        traverse(node.left);
    }

    traverse(root);
    return root;
};