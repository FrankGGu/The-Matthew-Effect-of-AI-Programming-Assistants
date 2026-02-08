var maximumSum = function(root) {
    let evenSum = 0;
    let oddSum = 0;
    let level = 0;

    const queue = [root];

    while (queue.length > 0) {
        const size = queue.length;
        let currentLevelSum = 0;

        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            currentLevelSum += node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        if (level % 2 === 0) {
            evenSum = Math.max(evenSum, currentLevelSum);
        } else {
            oddSum = Math.max(oddSum, currentLevelSum);
        }

        level++;
    }

    return Math.max(evenSum, oddSum);
};