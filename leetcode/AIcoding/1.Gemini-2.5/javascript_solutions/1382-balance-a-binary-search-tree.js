var balanceBST = function(root) {
    let sortedNodes = [];

    function inorderTraversal(node) {
        if (!node) {
            return;
        }
        inorderTraversal(node.left);
        sortedNodes.push(node);
        inorderTraversal(node.right);
    }

    inorderTraversal(root);

    function buildBalancedBST(nodes, start, end) {
        if (start > end) {
            return null;
        }

        let mid = Math.floor((start + end) / 2);
        let rootNode = nodes[mid];

        rootNode.left = buildBalancedBST(nodes, start, mid - 1);
        rootNode.right = buildBalancedBST(nodes, mid + 1, end);

        return rootNode;
    }

    return buildBalancedBST(sortedNodes, 0, sortedNodes.length - 1);
};