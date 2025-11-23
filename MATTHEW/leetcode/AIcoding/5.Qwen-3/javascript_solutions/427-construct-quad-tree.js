function construct(grid) {
    function buildTree(x, y, size) {
        if (size === 1) {
            return new Node(grid[x][y], true, null, null, null, null);
        }
        const half = size / 2;
        const topLeft = buildTree(x, y, half);
        const topRight = buildTree(x, y + half, half);
        const bottomLeft = buildTree(x + half, y, half);
        const bottomRight = buildTree(x + half, y + half, half);
        if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
            topLeft.val === topRight.val && topLeft.val === bottomLeft.val && topLeft.val === bottomRight.val) {
            return new Node(topLeft.val, true, null, null, null, null);
        } else {
            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }
    return buildTree(0, 0, grid.length);
}