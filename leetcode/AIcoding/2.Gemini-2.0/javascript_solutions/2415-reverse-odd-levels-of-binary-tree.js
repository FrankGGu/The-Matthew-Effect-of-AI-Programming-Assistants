var reverseOddLevels = function(root) {
    const reverseLevel = (level, nodes) => {
        if (nodes.length === 0) return;
        if (level % 2 === 1) {
            let left = 0;
            let right = nodes.length - 1;
            while (left < right) {
                let temp = nodes[left].val;
                nodes[left].val = nodes[right].val;
                nodes[right].val = temp;
                left++;
                right--;
            }
        }

        let nextLevelNodes = [];
        for (let node of nodes) {
            if (node.left) nextLevelNodes.push(node.left);
            if (node.right) nextLevelNodes.push(node.right);
        }
        reverseLevel(level + 1, nextLevelNodes);
    };

    reverseLevel(0, [root]);
    return root;
};