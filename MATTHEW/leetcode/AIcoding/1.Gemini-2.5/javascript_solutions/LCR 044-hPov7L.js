var largestValues = function(root) {
    const result = [];
    if (!root) {
        return result;
    }

    const queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentMax = -Infinity;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentMax = Math.max(currentMax, node.val);

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        result.push(currentMax);
    }

    return result;
};