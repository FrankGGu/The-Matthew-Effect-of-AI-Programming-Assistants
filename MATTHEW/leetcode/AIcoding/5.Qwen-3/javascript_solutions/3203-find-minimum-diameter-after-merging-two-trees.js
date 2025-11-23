function findMinimumDiameterAfterMergingTwoTrees(root1, root2) {
    function getDiameter(node) {
        if (!node) return 0;
        const left = getDepth(node.left);
        const right = getDepth(node.right);
        return Math.max(left + right + 1, getDiameter(node.left), getDiameter(node.right));
    }

    function getDepth(node) {
        if (!node) return 0;
        return 1 + Math.max(getDepth(node.left), getDepth(node.right));
    }

    const diameter1 = getDiameter(root1);
    const diameter2 = getDiameter(root2);

    const depth1 = getDepth(root1);
    const depth2 = getDepth(root2);

    return Math.min(diameter1, diameter2, depth1 + depth2 + 1);
}