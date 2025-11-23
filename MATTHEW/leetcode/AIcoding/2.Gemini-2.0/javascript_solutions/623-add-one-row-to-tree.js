var addOneRow = function(root, val, depth) {
    if (depth === 1) {
        const newRoot = new TreeNode(val);
        newRoot.left = root;
        return newRoot;
    }

    function traverse(node, currentDepth) {
        if (!node) return;

        if (currentDepth === depth - 1) {
            const leftNode = node.left;
            const rightNode = node.right;

            node.left = new TreeNode(val);
            node.right = new TreeNode(val);

            node.left.left = leftNode;
            node.right.right = rightNode;
            return;
        }

        traverse(node.left, currentDepth + 1);
        traverse(node.right, currentDepth + 1);
    }

    traverse(root, 1);
    return root;
};