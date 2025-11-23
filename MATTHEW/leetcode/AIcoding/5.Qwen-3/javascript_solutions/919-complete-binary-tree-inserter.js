function completeBinaryTreeInserter(root) {
    const queue = [];
    const result = [];

    if (root) {
        queue.push(root);
    }

    while (queue.length > 0) {
        const node = queue.shift();
        result.push(node);

        if (node.left) {
            queue.push(node.left);
        }
        if (node.right) {
            queue.push(node.right);
        }
    }

    return result;
}