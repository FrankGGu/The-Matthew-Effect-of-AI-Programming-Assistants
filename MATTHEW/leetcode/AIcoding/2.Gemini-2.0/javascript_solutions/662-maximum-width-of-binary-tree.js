var widthOfBinaryTree = function(root) {
    if (!root) return 0;

    let queue = [[root, 0]];
    let maxWidth = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let start = queue[0][1];
        let end = queue[levelSize - 1][1];
        maxWidth = Math.max(maxWidth, end - start + 1);

        for (let i = 0; i < levelSize; i++) {
            let [node, pos] = queue.shift();

            if (node.left) {
                queue.push([node.left, 2 * pos]);
            }
            if (node.right) {
                queue.push([node.right, 2 * pos + 1]);
            }
        }
    }

    return maxWidth;
};