var kthLargestLevelSum = function(root, k) {
    if (!root) return -1;

    const levelSums = [];
    const queue = [root];

    while (queue.length > 0) {
        const levelSize = queue.length;
        let levelSum = 0;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            levelSum += node.val;

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        levelSums.push(levelSum);
    }

    levelSums.sort((a, b) => b - a);

    if (k > levelSums.length) return -1;

    return levelSums[k - 1];
};