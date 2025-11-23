var averageOfLevels = function(root) {
    if (!root) return [];
    let queue = [root];
    let result = [];
    while (queue.length) {
        let levelSize = queue.length;
        let levelSum = 0;
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            levelSum += node.val;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
        result.push(levelSum / levelSize);
    }
    return result;
};