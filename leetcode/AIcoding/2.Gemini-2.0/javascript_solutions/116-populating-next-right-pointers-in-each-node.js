var connect = function(root) {
    if (!root) return root;

    let queue = [root];

    while (queue.length > 0) {
        let size = queue.length;
        for (let i = 0; i < size; i++) {
            let node = queue.shift();
            if (i < size - 1) {
                node.next = queue[0];
            }
            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
    }

    return root;
};