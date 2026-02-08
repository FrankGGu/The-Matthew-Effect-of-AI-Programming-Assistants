var isLeafSimilar = function(root1, root2) {
    function getLeafSequence(root) {
        const leaves = [];
        if (!root) {
            return leaves;
        }

        const stack = [root];
        while (stack.length > 0) {
            const node = stack.pop();

            if (!node.left && !node.right) {
                leaves.push(node.val);
            }

            if (node.right) {
                stack.push(node.right);
            }
            if (node.left) {
                stack.push(node.left);
            }
        }
        return leaves;
    }

    const leaves1 = getLeafSequence(root1);
    const leaves2 = getLeafSequence(root2);

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