var findDuplicateSubtrees = function(root) {
    const map = new Map();
    const result = [];

    const serialize = (node) => {
        if (!node) return '#';
        const serial = `${node.val},${serialize(node.left)},${serialize(node.right)}`;
        if (map.has(serial)) {
            map.get(serial).count++;
            if (map.get(serial).count === 2) {
                result.push(node);
            }
        } else {
            map.set(serial, { count: 1, node });
        }
        return serial;
    };

    serialize(root);
    return result;
};