var findBottomLeftValue = function(root) {
    let queue = [root];
    let leftmostValue;

    while (queue.length > 0) {
        let size = queue.length;
        leftmostValue = queue[0].val;

        for (let i = 0; i < size; i++) {
            let node = queue.shift();
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
    }

    return leftmostValue;
};