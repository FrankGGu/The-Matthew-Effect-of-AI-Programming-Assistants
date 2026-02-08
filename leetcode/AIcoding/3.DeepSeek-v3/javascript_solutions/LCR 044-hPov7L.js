var largestValues = function(root) {
    if (!root) return [];
    let queue = [root];
    let result = [];
    while (queue.length) {
        let levelSize = queue.length;
        let max = -Infinity;
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            max = Math.max(max, node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
        result.push(max);
    }
    return result;
};