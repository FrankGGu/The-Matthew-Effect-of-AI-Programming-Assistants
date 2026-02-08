var averageOfLevels = function(root) {
    const result = [];
    const queue = [root];

    while (queue.length > 0) {
        let sum = 0;
        let count = queue.length;

        for (let i = 0; i < count; i++) {
            const node = queue.shift();
            sum += node.val;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        result.push(sum / count);
    }

    return result;
};