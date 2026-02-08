var bstToGst = function(root) {
    let currentSum = 0;

    function traverse(node) {
        if (!node) {
            return;
        }

        traverse(node.right);

        currentSum += node.val;
        node.val = currentSum;

        traverse(node.left);
    }

    traverse(root);
    return root;
};