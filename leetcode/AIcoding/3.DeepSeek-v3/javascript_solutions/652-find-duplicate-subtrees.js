var findDuplicateSubtrees = function(root) {
    const map = new Map();
    const result = [];

    function traverse(node) {
        if (!node) return '#';
        const left = traverse(node.left);
        const right = traverse(node.right);
        const serial = `${node.val},${left},${right}`;

        if (map.has(serial)) {
            map.set(serial, map.get(serial) + 1);
            if (map.get(serial) === 2) {
                result.push(node);
            }
        } else {
            map.set(serial, 1);
        }

        return serial;
    }

    traverse(root);
    return result;
};