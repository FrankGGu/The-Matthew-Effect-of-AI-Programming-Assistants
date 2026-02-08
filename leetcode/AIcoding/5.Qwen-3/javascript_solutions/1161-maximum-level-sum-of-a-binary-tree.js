function maxLevelSum(root) {
    let maxSum = -Infinity;
    let level = 0;
    let maxLevel = 0;
    let queue = [root];

    while (queue.length > 0) {
        let size = queue.length;
        let sum = 0;

        for (let i = 0; i < size; i++) {
            let node = queue.shift();
            sum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        level++;
        if (sum > maxSum) {
            maxSum = sum;
            maxLevel = level;
        }
    }

    return maxLevel;
}