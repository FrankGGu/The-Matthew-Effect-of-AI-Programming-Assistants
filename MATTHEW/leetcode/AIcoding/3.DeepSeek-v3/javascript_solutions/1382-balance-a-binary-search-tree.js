var balanceBST = function(root) {
    const nodes = [];

    function inorder(node) {
        if (!node) return;
        inorder(node.left);
        nodes.push(node.val);
        inorder(node.right);
    }

    function buildBalancedBST(left, right) {
        if (left > right) return null;
        const mid = Math.floor((left + right) / 2);
        const node = new TreeNode(nodes[mid]);
        node.left = buildBalancedBST(left, mid - 1);
        node.right = buildBalancedBST(mid + 1, right);
        return node;
    }

    inorder(root);
    return buildBalancedBST(0, nodes.length - 1);
};