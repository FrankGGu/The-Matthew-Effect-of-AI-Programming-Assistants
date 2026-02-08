var btreeGameWinningMove = function(root, n, b) {
    let leftCount = 0;
    let rightCount = 0;

    function countNodes(node) {
        if (!node) return 0;
        return 1 + countNodes(node.left) + countNodes(node.right);
    }

    function findNode(node, target) {
        if (!node) return null;
        if (node.val === target) return node;
        let leftResult = findNode(node.left, target);
        if (leftResult) return leftResult;
        return findNode(node.right, target);
    }

    let bNode = findNode(root, b);
    leftCount = countNodes(bNode.left);
    rightCount = countNodes(bNode.right);

    let parentCount = n - 1 - leftCount - rightCount;

    return parentCount > leftCount + rightCount + 1 || leftCount > parentCount + rightCount + 1 || rightCount > parentCount + leftCount + 1;
};