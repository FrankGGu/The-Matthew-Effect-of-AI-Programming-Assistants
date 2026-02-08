var kthLargestLevelSum = function(root, k) {
    const levelSums = [];
    const queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevelSum = 0;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentLevelSum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        levelSums.push(currentLevelSum);
    }

    levelSums.sort((a, b) => b - a);

    return levelSums[k - 1];
};