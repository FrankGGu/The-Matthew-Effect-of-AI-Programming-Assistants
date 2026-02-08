var findBottomLeftValue = function(root) {
    let bottomLeft = root.val;
    let queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        bottomLeft = queue[0].val;

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
    }

    return bottomLeft;
};