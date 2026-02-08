var leafSimilar = function(root1, root2) {
    const getLeaves = (root) => {
        const leaves = [];
        const stack = [root];
        while (stack.length) {
            const node = stack.pop();
            if (!node.left && !node.right) {
                leaves.push(node.val);
            } else {
                if (node.right) {
                    stack.push(node.right);
                }
                if (node.left) {
                    stack.push(node.left);
                }
            }
        }
        return leaves;
    };

    const leaves1 = getLeaves(root1);
    const leaves2 = getLeaves(root2);

    if (leaves1.length !== leaves2.length) {
        return false;
    }

    for (let i = 0; i < leaves1.length; i++) {
        if (leaves1[i] !== leaves2[i]) {
            return false;
        }
    }

    return true;
};