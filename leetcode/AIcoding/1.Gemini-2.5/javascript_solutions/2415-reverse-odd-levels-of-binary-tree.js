var reverseOddLevels = function(root) {
    if (!root) {
        return null;
    }

    let queue = [root];
    let level = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevelNodes = [];
        let currentLevelValues = [];
        let nextLevelChildren = [];

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentLevelNodes.push(node);
            currentLevelValues.push(node.val);

            if (node.left) {
                nextLevelChildren.push(node.left);
            }
            if (node.right) {
                nextLevelChildren.push(node.right);
            }
        }

        if (level % 2 !== 0) {
            currentLevelValues.reverse();
            for (let i = 0; i < levelSize; i++) {
                currentLevelNodes[i].val = currentLevelValues[i];
            }
        }

        queue = nextLevelChildren;
        level++;
    }

    return root;
};