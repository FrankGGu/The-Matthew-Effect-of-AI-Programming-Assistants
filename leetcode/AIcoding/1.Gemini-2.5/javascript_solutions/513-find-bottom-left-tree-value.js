var findBottomLeftValue = function(root) {
    if (!root) {
        return null;
    }

    let queue = [root];
    let bottomLeftValue = root.val;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let firstNodeOfLevel = null;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();

            if (i === 0) {
                firstNodeOfLevel = node;
            }

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        // After processing a level, if there are more nodes in the queue,
        // it means we are moving to the next level. The first node of that
        // next level (if it exists) will be the new leftmost candidate.
        // We update bottomLeftValue with the first node of the *current* level
        // if the queue is not empty after this level, meaning there's a deeper level.
        // Or, more simply, the last `firstNodeOfLevel.val` assigned will be the answer.
        // The current loop's `firstNodeOfLevel` is the leftmost node of the current level.
        // If this is the deepest level, this will be the final answer.
        // If there are more levels, this value will be overwritten by the leftmost node of the next level.
        // So, the final value of `bottomLeftValue` will be the leftmost node of the deepest level.
        bottomLeftValue = firstNodeOfLevel.val;
    }

    return bottomLeftValue;
};