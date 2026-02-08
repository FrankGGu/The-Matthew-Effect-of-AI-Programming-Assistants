var isCompleteBinaryTree = function(root) {
    if (!root) return true;

    let queue = [root];
    let reachedEnd = false;

    while (queue.length) {
        let node = queue.shift();

        if (!node) {
            reachedEnd = true;
        } else {
            if (reachedEnd) return false;
            queue.push(node.left);
            queue.push(node.right);
        }
    }

    return true;
};