var btreeGameWinningMove = function(root, n, x) {
    let leftCount = 0, rightCount = 0;

    const countNodes = (node) => {
        if (!node) return 0;
        const left = countNodes(node.left);
        const right = countNodes(node.right);
        if (node.val === x) {
            leftCount = left;
            rightCount = right;
        }
        return left + right + 1;
    };

    countNodes(root);
    const parentCount = n - leftCount - rightCount - 1;
    const max = Math.max(parentCount, leftCount, rightCount);
    return max > n / 2;
};