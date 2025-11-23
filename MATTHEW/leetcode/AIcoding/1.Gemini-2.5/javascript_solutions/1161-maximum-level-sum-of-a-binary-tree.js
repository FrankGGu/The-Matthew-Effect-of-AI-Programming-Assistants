var maxLevelSum = function(root) {
    if (!root) {
        return 0;
    }

    let maxSum = -Infinity;
    let maxLevel = 1;
    let currentLevel = 1;

    let queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevelSum = 0;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentLevelSum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        if (currentLevelSum > maxSum) {
            maxSum = currentLevelSum;
            maxLevel = currentLevel;
        }
        currentLevel++;
    }

    return maxLevel;
};