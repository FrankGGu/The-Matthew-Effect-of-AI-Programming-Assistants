var decorateRecord = function(root) {
    if (!root) return [];
    const result = [];
    const queue = [root];
    let isReverse = false;

    while (queue.length > 0) {
        const levelSize = queue.length;
        const currentLevel = [];

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentLevel.push(node.val);

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (isReverse) {
            result.push(currentLevel.reverse());
        } else {
            result.push(currentLevel);
        }

        isReverse = !isReverse;
    }

    return result;
};