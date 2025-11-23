var diameterOfBinaryTree = function(root) {
    let diameter = 0;

    function depth(node) {
        if (!node) {
            return 0;
        }

        let leftDepth = depth(node.left);
        let rightDepth = depth(node.right);

        diameter = Math.max(diameter, leftDepth + rightDepth);

        return Math.max(leftDepth, rightDepth) + 1;
    }

    depth(root);
    return diameter;
};