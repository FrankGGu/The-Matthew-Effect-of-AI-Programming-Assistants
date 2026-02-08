function balanceBST(root) {
    const nodes = [];

    function inOrderTraversal(node) {
        if (!node) return;
        inOrderTraversal(node.left);
        nodes.push(node.val);
        inOrderTraversal(node.right);
    }

    inOrderTraversal(root);

    function buildBalancedBST(start, end) {
        if (start > end) return null;
        const mid = Math.floor((start + end) / 2);
        const node = new TreeNode(nodes[mid]);
        node.left = buildBalancedBST(start, mid - 1);
        node.right = buildBalancedBST(mid + 1, end);
        return node;
    }

    return buildBalancedBST(0, nodes.length - 1);
}

function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}