function isCompleteTree(root) {
    if (!root) return true;

    const queue = [root];
    let flag = false;

    while (queue.length > 0) {
        const node = queue.shift();

        if (!node) {
            flag = true;
            continue;
        }

        if (flag) return false;

        queue.push(node.left);
        queue.push(node.right);
    }

    return true;
}