var findBottomLeftValue = function(root) {
    let queue = [root];
    let leftmostValue;

    while (queue.length) {
        let size = queue.length;
        for (let i = 0; i < size; i++) {
            let node = queue.shift();
            if (i === 0) leftmostValue = node.val;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
    }

    return leftmostValue;
};