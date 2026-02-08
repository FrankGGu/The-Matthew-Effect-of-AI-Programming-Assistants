var btreeGameWinningMove = function(root, n, x) {
    let leftSize = 0;
    let rightSize = 0;

    function countNodes(node) {
        if (!node) {
            return 0;
        }
        return 1 + countNodes(node.left) + countNodes(node.right);
    }

    function findX(node) {
        if (!node) {
            return false;
        }
        if (node.val === x) {
            leftSize = countNodes(node.left);
            rightSize = countNodes(node.right);
            return true;
        }
        return findX(node.left) || findX(node.right);
    }

    findX(root);

    let parentSize = n - 1 - leftSize - rightSize;

    return Math.max(parentSize, leftSize, rightSize) > n / 2;
};