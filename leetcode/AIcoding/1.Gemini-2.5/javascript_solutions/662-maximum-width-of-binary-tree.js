var widthOfBinaryTree = function(root) {
    if (!root) {
        return 0;
    }

    let maxWidth = 1;
    let queue = [[root, 0]];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let firstPosInLevel = queue[0][1];

        let currentLevelLeft = -1;
        let currentLevelRight = -1;

        for (let i = 0; i < levelSize; i++) {
            let [node, pos] = queue.shift();

            if (currentLevelLeft === -1) {
                currentLevelLeft = pos;
            }
            currentLevelRight = pos;

            let normalizedPos = pos - firstPosInLevel; 

            if (node.left) {
                queue.push([node.left, 2 * normalizedPos]);
            }
            if (node.right) {
                queue.push([node.right, 2 * normalizedPos + 1]);
            }
        }

        maxWidth = Math.max(maxWidth, currentLevelRight - currentLevelLeft + 1);
    }

    return maxWidth;
};