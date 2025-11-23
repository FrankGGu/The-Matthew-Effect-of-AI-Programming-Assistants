function printTree(root) {
    function getHeight(node) {
        if (!node) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }

    const height = getHeight(root) - 1;
    const width = Math.pow(2, height + 1) - 1;
    const result = Array.from({ length: height + 1 }, () => Array(width).fill(""));

    function fill(node, row, col) {
        if (!node) return;
        result[row][col] = node.val.toString();
        fill(node.left, row + 1, col - Math.pow(2, height - row - 1));
        fill(node.right, row + 1, col + Math.pow(2, height - row - 1));
    }

    fill(root, 0, Math.floor(width / 2));
    return result;
}