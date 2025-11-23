var deepestLeavesSum = function(root) {
    if (!root) {
        return 0;
    }

    let queue = [root];
    let currentLevelSum = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        currentLevelSum = 0; 

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentLevelSum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
    }

    return currentLevelSum;
};