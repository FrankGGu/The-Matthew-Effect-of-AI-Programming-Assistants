var levelOrder = function(root) {
    const result = [];
    if (!root) {
        return result;
    }

    const queue = [root];

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
        result.push(currentLevelNodes);
    }

    return result;
};