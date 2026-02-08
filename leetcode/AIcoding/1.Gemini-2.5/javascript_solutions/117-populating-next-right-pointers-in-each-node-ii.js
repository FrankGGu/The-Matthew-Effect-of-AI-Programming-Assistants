var connect = function(root) {
    if (!root) {
        return root;
    }

    const queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let prevNode = null;

        for (let i = 0; i < levelSize; i++) {
            const currentNode = queue.shift();

            if (prevNode) {
                prevNode.next = currentNode;
            }
            prevNode = currentNode;

            if (currentNode.left) {
                queue.push(currentNode.left);
            }
            if (currentNode.right) {
                queue.push(currentNode.right);
            }
        }
    }

    return root;
};