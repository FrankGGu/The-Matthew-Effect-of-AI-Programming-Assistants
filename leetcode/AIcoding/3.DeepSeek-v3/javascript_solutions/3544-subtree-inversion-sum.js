var subtreeInversionSum = function(root) {
    let sum = 0;

    const invertTree = (node) => {
        if (!node) return null;
        const left = invertTree(node.left);
        const right = invertTree(node.right);
        node.left = right;
        node.right = left;
        return node;
    };

    const calculateSum = (node) => {
        if (!node) return 0;
        const leftSum = calculateSum(node.left);
        const rightSum = calculateSum(node.right);
        const total = node.val + leftSum + rightSum;
        sum += total;
        return total;
    };

    const traverse = (node) => {
        if (!node) return;
        traverse(node.left);
        traverse(node.right);
        invertTree(node);
        calculateSum(node);
    };

    traverse(root);
    return sum;
};