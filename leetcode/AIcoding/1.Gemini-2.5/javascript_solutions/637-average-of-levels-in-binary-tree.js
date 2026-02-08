var averageOfLevels = function(root) {
    const result = [];
    if (!root) {
        return result;
    }

    const queue = [root];

    while (queue.length > 0) {
        let levelSum = 0;
        const levelSize = queue.length;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            levelSum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        result.push(levelSum / levelSize);
    }

    return result;
};