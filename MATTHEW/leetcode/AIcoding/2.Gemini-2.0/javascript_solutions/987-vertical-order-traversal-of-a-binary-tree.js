var verticalTraversal = function(root) {
    const map = new Map();
    const queue = [[root, 0, 0]];

    while (queue.length) {
        const [node, col, row] = queue.shift();

        if (!map.has(col)) {
            map.set(col, []);
        }

        map.get(col).push({ val: node.val, row });

        if (node.left) {
            queue.push([node.left, col - 1, row + 1]);
        }

        if (node.right) {
            queue.push([node.right, col + 1, row + 1]);
        }
    }

    const sortedKeys = Array.from(map.keys()).sort((a, b) => a - b);
    const result = [];

    for (const key of sortedKeys) {
        const nodes = map.get(key);
        nodes.sort((a, b) => {
            if (a.row !== b.row) {
                return a.row - b.row;
            } else {
                return a.val - b.val;
            }
        });

        const column = nodes.map(node => node.val);
        result.push(column);
    }

    return result;
};