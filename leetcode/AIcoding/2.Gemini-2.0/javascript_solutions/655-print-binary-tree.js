var printTree = function(root) {
    const getHeight = (node) => {
        if (!node) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    };

    const height = getHeight(root);
    const width = Math.pow(2, height) - 1;
    const result = Array(height).fill(null).map(() => Array(width).fill(""));

    const fillResult = (node, row, left, right) => {
        if (!node) return;
        const mid = Math.floor((left + right) / 2);
        result[row][mid] = String(node.val);
        fillResult(node.left, row + 1, left, mid - 1);
        fillResult(node.right, row + 1, mid + 1, right);
    };

    fillResult(root, 0, 0, width - 1);
    return result;
};