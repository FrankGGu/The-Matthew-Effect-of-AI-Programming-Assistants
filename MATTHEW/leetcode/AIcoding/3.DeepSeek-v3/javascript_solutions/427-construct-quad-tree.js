var construct = function(grid) {
    function helper(x, y, len) {
        if (len === 1) {
            return new Node(grid[x][y] === 1, true, null, null, null, null);
        }

        const half = len / 2;
        const topLeft = helper(x, y, half);
        const topRight = helper(x, y + half, half);
        const bottomLeft = helper(x + half, y, half);
        const bottomRight = helper(x + half, y + half, half);

        if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
            topLeft.val === topRight.val && topRight.val === bottomLeft.val && bottomLeft.val === bottomRight.val) {
            return new Node(topLeft.val, true, null, null, null, null);
        } else {
            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }

    return helper(0, 0, grid.length);
};