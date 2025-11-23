var maxLevelSum = function(root) {
    let maxSum = -Infinity, maxLevel = 1, level = 1;
    const queue = [root];

    while (queue.length > 0) {
        let sum = 0, size = queue.length;

        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            sum += node.val;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (sum > maxSum) {
            maxSum = sum;
            maxLevel = level;
        }
        level++;
    }

    return maxLevel;
};