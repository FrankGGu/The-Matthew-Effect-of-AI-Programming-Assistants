var rightSideView = function(root) {
    const result = [];
    if (!root) {
        return result;
    }

    const queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let rightmostNodeValue;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();

            rightmostNodeValue = node.val;

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        result.push(rightmostNodeValue);
    }

    return result;
};