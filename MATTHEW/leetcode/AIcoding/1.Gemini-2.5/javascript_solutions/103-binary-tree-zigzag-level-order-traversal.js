var zigzagLevelOrder = function(root) {
    const result = [];
    if (!root) {
        return result;
    }

    const queue = [root];
    let leftToRight = true;

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

        if (!leftToRight) {
            currentLevelNodes.reverse();
        }

        result.push(currentLevelNodes);
        leftToRight = !leftToRight;
    }

    return result;
};