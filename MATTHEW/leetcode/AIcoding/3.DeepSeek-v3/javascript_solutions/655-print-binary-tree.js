var printTree = function(root) {
    const getHeight = (node) => {
        if (!node) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    };

    const height = getHeight(root);
    const width = Math.pow(2, height) - 1;
    const res = Array(height).fill().map(() => Array(width).fill(""));

    const fill = (node, row, left, right) => {
        if (!node) return;
        const mid = Math.floor((left + right) / 2);
        res[row][mid] = node.val.toString();
        fill(node.left, row + 1, left, mid - 1);
        fill(node.right, row + 1, mid + 1, right);
    };

    fill(root, 0, 0, width - 1);
    return res;
};