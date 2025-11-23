var decorateRecord = function(root) {
    if (!root) {
        return [];
    }

    const result = [];
    const queue = [root];
    let level = 0;

    while (queue.length > 0) {
        const levelSize = queue.length;
        const currentLevelNodes = [];

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            currentLevelNodes.push(node.val);

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        if (level % 2 === 1) { // Odd level, reverse
            currentLevelNodes.reverse();
        }

        result.push(currentLevelNodes);
        level++;
    }

    return result;
};