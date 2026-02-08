var maxLevelSum = function(root) {
    if (!root) return 0;

    let maxSum = -Infinity;
    let resultLevel = 0;
    let queue = [root];
    let level = 1;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentSum = 0;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentSum += node.val;

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (currentSum > maxSum) {
            maxSum = currentSum;
            resultLevel = level;
        }

        level++;
    }

    return resultLevel;
};