class Node {
    constructor(val, isLeaf, topLeft, topRight, bottomLeft, bottomRight) {
        this.val = val;
        this.isLeaf = isLeaf;
        this.topLeft = topLeft;
        this.topRight = topRight;
        this.bottomLeft = bottomLeft;
        this.bottomRight = bottomRight;
    }
}

var construct = function(grid) {
    const n = grid.length;

    const build = (x, y, length) => {
        if (length === 1) {
            return new Node(grid[x][y] === 1, true);
        }

        const half = length / 2;
        const topLeft = build(x, y, half);
        const topRight = build(x, y + half, half);
        const bottomLeft = build(x + half, y, half);
        const bottomRight = build(x + half, y + half, half);

        if (topLeft.isLeaf && topRight.isLeaf && bottomLeft.isLeaf && bottomRight.isLeaf &&
            topLeft.val === topRight.val && topLeft.val === bottomLeft.val && topLeft.val === bottomRight.val) {
            return new Node(topLeft.val, true);
        }

        return new Node(1, false, topLeft, topRight, bottomLeft, bottomRight);
    };

    return build(0, 0, n);
};