var largestValues = function(root) {
    if (!root) return [];
    const result = [];
    const queue = [root];

    while (queue.length > 0) {
        let rowSize = queue.length;
        let maxVal = -Infinity;

        for (let i = 0; i < rowSize; i++) {
            const node = queue.shift();
            maxVal = Math.max(maxVal, node.val);

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        result.push(maxVal);
    }

    return result;
};