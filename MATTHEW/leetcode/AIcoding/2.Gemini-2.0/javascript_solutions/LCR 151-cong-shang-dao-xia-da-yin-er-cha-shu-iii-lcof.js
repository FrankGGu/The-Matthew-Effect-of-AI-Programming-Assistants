var decorateRecord = function(root) {
    const result = [];
    if (!root) return result;

    const q = [[root, 0]];
    const map = new Map();

    while (q.length > 0) {
        const [node, level] = q.shift();

        if (!map.has(level)) {
            map.set(level, []);
        }
        map.get(level).push(node.val);

        if (node.left) {
            q.push([node.left, level + 1]);
        }
        if (node.right) {
            q.push([node.right, level + 1]);
        }
    }

    for (let i = 0; i < map.size; i++) {
        result.push(map.get(i));
    }

    return result;
};