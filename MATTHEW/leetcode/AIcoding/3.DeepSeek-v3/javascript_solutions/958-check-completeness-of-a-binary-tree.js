var isCompleteTree = function(root) {
    if (!root) return true;
    let queue = [root];
    let seenNull = false;

    while (queue.length > 0) {
        let node = queue.shift();
        if (!node) {
            seenNull = true;
            continue;
        }
        if (seenNull) return false;
        queue.push(node.left);
        queue.push(node.right);
    }
    return true;
};