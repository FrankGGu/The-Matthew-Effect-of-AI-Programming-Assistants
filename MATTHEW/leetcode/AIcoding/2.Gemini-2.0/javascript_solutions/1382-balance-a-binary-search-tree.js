var balanceBST = function(root) {
    const inorder = [];

    function inorderTraversal(node) {
        if (!node) return;
        inorderTraversal(node.left);
        inorder.push(node.val);
        inorderTraversal(node.right);
    }

    function buildBalancedBST(arr, start, end) {
        if (start > end) return null;

        const mid = Math.floor((start + end) / 2);
        const node = new TreeNode(arr[mid]);

        node.left = buildBalancedBST(arr, start, mid - 1);
        node.right = buildBalancedBST(arr, mid + 1, end);

        return node;
    }

    inorderTraversal(root);
    return buildBalancedBST(inorder, 0, inorder.length - 1);
};