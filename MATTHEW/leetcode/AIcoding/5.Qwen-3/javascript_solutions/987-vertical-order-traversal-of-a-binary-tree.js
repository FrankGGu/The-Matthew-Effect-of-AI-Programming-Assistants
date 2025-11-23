var verticalOrder = function(root) {
    if (!root) return [];

    const map = new Map();
    const queue = [[root, 0]];
    let minCol = 0, maxCol = 0;

    while (queue.length) {
        const [node, col] = queue.shift();

        if (!map.has(col)) {
            map.set(col, []);
        }
        map.get(col).push(node.val);

        if (node.left) {
            queue.push([node.left, col - 1]);
            minCol = Math.min(minCol, col - 1);
        }
        if (node.right) {
            queue.push([node.right, col + 1]);
            maxCol = Math.max(maxCol, col + 1);
        }
    }

    const result = [];
    for (let i = minCol; i <= maxCol; i++) {
        result.push(...map.get(i));
    }

    return result;
};