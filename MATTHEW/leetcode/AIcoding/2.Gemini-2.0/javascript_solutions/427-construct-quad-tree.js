var construct = function(grid) {
    const n = grid.length;

    function buildTree(rowStart, rowEnd, colStart, colEnd) {
        let isLeaf = true;
        let val = grid[rowStart][colStart];

        for (let i = rowStart; i < rowEnd; i++) {
            for (let j = colStart; j < colEnd; j++) {
                if (grid[i][j] !== val) {
                    isLeaf = false;
                    break;
                }
            }
            if (!isLeaf) break;
        }

        if (isLeaf) {
            return new Node(val === 1, true, null, null, null, null);
        } else {
            const midRow = Math.floor((rowStart + rowEnd) / 2);
            const midCol = Math.floor((colStart + colEnd) / 2);

            const topLeft = buildTree(rowStart, midRow, colStart, midCol);
            const topRight = buildTree(rowStart, midRow, midCol, colEnd);
            const bottomLeft = buildTree(midRow, rowEnd, colStart, midCol);
            const bottomRight = buildTree(midRow, rowEnd, midCol, colEnd);

            return new Node(false, false, topLeft, topRight, bottomLeft, bottomRight);
        }
    }

    return buildTree(0, n, 0, n);
};