var verticalTraversal = function(root) {
    if (!root) {
        return [];
    }

    const columnMap = new Map();
    const queue = [[root, 0, 0]];
    let minCol = 0;
    let maxCol = 0;

    while (queue.length > 0) {
        const [node, col, row] = queue.shift();

        if (!columnMap.has(col)) {
            columnMap.set(col, []);
        }
        columnMap.get(col).push([row, node.val]);

        minCol = Math.min(minCol, col);
        maxCol = Math.max(maxCol, col);

        if (node.left) {
            queue.push([node.left, col - 1, row + 1]);
        }
        if (node.right) {
            queue.push([node.right, col + 1, row + 1]);
        }
    }

    const result = [];
    for (let col = minCol; col <= maxCol; col++) {
        const nodesInCol = columnMap.get(col);

        nodesInCol.sort((a, b) => {
            if (a[0] !== b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        result.push(nodesInCol.map(item => item[1]));
    }

    return result;
};