var isCompleteTree = function(root) {
    if (!root) {
        return true;
    }

    const queue = [root];
    let foundNull = false;

    while (queue.length > 0) {
        const node = queue.shift();

        if (node === null) {
            foundNull = true;
        } else {
            if (foundNull) {
                return false;
            }
            queue.push(node.left);
            queue.push(node.right);
        }
    }

    return true;
};