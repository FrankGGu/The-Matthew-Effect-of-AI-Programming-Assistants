var lightUp = function(root) {
    let set = new Set();
    let queue = [root];

    while (queue.length > 0) {
        let node = queue.shift();
        if (!set.has(node.val)) {
            set.add(node.val);
        }
        if (node.left) {
            queue.push(node.left);
        }
        if (node.right) {
            queue.push(node.right);
        }
    }

    return set.size;
};