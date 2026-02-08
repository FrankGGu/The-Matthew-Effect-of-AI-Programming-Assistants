var widthOfBinaryTree = function(root) {
    if (!root) return 0;
    let maxWidth = 0;
    const queue = [[root, 0]];

    while (queue.length) {
        const levelSize = queue.length;
        let left = queue[0][1];
        let right = left;

        for (let i = 0; i < levelSize; i++) {
            const [node, pos] = queue.shift();
            right = pos;

            if (node.left) {
                queue.push([node.left, pos * 2]);
            }
            if (node.right) {
                queue.push([node.right, pos * 2 + 1]);
            }
        }
        maxWidth = Math.max(maxWidth, right - left + 1);
    }

    return maxWidth;
};