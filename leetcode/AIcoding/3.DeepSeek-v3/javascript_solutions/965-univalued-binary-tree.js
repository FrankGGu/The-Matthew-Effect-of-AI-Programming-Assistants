var isUnivalTree = function(root) {
    if (!root) return true;
    const value = root.val;
    const queue = [root];

    while (queue.length > 0) {
        const node = queue.shift();
        if (node.val !== value) return false;
        if (node.left) queue.push(node.left);
        if (node.right) queue.push(node.right);
    }

    return true;
};