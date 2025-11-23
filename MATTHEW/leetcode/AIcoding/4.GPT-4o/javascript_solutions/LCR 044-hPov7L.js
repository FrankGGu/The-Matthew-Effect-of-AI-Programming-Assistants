function largestValues(root) {
    if (!root) return [];
    const result = [];
    const queue = [root];

    while (queue.length) {
        let max = -Infinity;
        const size = queue.length;

        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            max = Math.max(max, node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        result.push(max);
    }

    return result;
}