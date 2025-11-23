var widthOfBinaryTree = function(root) {
    if (!root) return 0;
    let maxWidth = 0;
    let queue = [[root, 0]];

    while (queue.length) {
        let size = queue.length;
        let [firstIndex] = queue[0];
        let lastIndex = firstIndex;

        for (let i = 0; i < size; i++) {
            let [node, index] = queue.shift();
            lastIndex = index;
            if (node.left) queue.push([node.left, 2 * index]);
            if (node.right) queue.push([node.right, 2 * index + 1]);
        }

        maxWidth = Math.max(maxWidth, lastIndex - firstIndex + 1);
    }

    return maxWidth;
};