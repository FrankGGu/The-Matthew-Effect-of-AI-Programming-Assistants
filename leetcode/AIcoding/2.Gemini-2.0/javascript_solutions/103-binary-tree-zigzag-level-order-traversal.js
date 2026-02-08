var zigzagLevelOrder = function(root) {
    if (!root) return [];

    const result = [];
    const queue = [root];
    let level = 0;

    while (queue.length > 0) {
        const levelSize = queue.length;
        const currentLevel = [];

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentLevel.push(node.val);

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (level % 2 !== 0) {
            currentLevel.reverse();
        }

        result.push(currentLevel);
        level++;
    }

    return result;
};