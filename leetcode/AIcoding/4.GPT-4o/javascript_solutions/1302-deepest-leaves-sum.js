var deepestLeavesSum = function(root) {
    if (!root) return 0;
    let queue = [root];
    let sum = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        sum = 0;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            sum += node.val;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
    }

    return sum;
};