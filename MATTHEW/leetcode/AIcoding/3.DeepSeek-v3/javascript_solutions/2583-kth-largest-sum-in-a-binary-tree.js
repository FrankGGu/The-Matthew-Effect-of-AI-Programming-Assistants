var kthLargestLevelSum = function(root, k) {
    if (!root) return -1;

    let queue = [root];
    let levelSums = [];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentSum = 0;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentSum += node.val;

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        levelSums.push(currentSum);
    }

    if (levelSums.length < k) return -1;

    levelSums.sort((a, b) => b - a);
    return levelSums[k - 1];
};