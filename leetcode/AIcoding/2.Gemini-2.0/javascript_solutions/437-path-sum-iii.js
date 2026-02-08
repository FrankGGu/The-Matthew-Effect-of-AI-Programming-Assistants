var pathSum = function(root, targetSum) {
    let count = 0;

    const pathSumRecursive = (node, currentSum) => {
        if (!node) {
            return;
        }

        currentSum += node.val;

        if (currentSum === targetSum) {
            count++;
        }

        pathSumRecursive(node.left, currentSum);
        pathSumRecursive(node.right, currentSum);
    }

    const traverse = (node) => {
        if (!node) {
            return;
        }

        pathSumRecursive(node, 0);
        traverse(node.left);
        traverse(node.right);
    }

    traverse(root);

    return count;
};