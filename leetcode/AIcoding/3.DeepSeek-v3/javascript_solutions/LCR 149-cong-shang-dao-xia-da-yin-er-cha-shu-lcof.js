var decorateRecord = function(root) {
    if (!root) return [];
    const queue = [root];
    const result = [];
    while (queue.length > 0) {
        const node = queue.shift();
        result.push(node.val);
        if (node.left) queue.push(node.left);
        if (node.right) queue.push(node.right);
    }
    return result;
};