var lcaDeepestLeaves = function(root) {
    let depth = 0;

    const getDepth = (node) => {
        if (!node) return 0;
        let leftDepth = getDepth(node.left);
        let rightDepth = getDepth(node.right);
        depth = Math.max(depth, leftDepth + rightDepth + 1);
        return Math.max(leftDepth, rightDepth) + 1;
    };

    getDepth(root);

    const findLCA = (node, currentDepth) => {
        if (!node) return null;
        if (currentDepth === depth) return node;
        let left = findLCA(node.left, currentDepth + 1);
        let right = findLCA(node.right, currentDepth + 1);
        if (left && right) return node;
        return left ? left : right;
    };

    return findLCA(root, 1);
};