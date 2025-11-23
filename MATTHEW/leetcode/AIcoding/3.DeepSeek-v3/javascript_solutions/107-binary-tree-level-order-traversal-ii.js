var levelOrderBottom = function(root) {
    if (!root) return [];
    let result = [];
    let queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevel = [];

        for (let i = 0; i < levelSize; i++) {
            let currentNode = queue.shift();
            currentLevel.push(currentNode.val);

            if (currentNode.left) queue.push(currentNode.left);
            if (currentNode.right) queue.push(currentNode.right);
        }

        result.unshift(currentLevel);
    }

    return result;
};