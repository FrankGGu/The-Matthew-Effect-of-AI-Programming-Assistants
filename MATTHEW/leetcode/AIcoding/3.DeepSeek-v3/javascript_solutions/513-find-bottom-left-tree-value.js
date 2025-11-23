var findBottomLeftValue = function(root) {
    let queue = [root];
    let leftmost = root.val;

    while (queue.length > 0) {
        let levelSize = queue.length;
        leftmost = queue[0].val;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
    }

    return leftmost;
};