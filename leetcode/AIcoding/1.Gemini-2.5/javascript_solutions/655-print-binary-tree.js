var printTree = function(root) {
    const getHeight = (node) => {
        if (!node) {
            return 0;
        }
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    };

    const m = getHeight(root);
    const n = Math.pow(2, m) - 1;

    const result = Array(m).fill(0).map(() => Array(n).fill(""));

    const placeNode = (node, row, col, totalRows) => {
        if (!node) {
            return;
        }

        result[row][col] = String(node.val);

        const offset = Math.pow(2, totalRows - row - 2);

        if (node.left) {
            placeNode(node.left, row + 1, col - offset, totalRows);
        }

        if (node.right) {
            placeNode(node.right, row + 1, col + offset, totalRows);
        }
    };

    placeNode(root, 0, (n - 1) / 2, m);

    return result;
};