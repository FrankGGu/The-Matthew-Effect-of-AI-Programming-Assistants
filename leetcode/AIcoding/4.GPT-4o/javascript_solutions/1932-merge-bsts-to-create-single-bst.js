class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

function mergeBSTs(root1, root2) {
    const values = [];

    function inorderTraversal(node) {
        if (!node) return;
        inorderTraversal(node.left);
        values.push(node.val);
        inorderTraversal(node.right);
    }

    inorderTraversal(root1);
    inorderTraversal(root2);

    values.sort((a, b) => a - b);

    function sortedArrayToBST(arr, start, end) {
        if (start > end) return null;
        const mid = Math.floor((start + end) / 2);
        const node = new TreeNode(arr[mid]);
        node.left = sortedArrayToBST(arr, start, mid - 1);
        node.right = sortedArrayToBST(arr, mid + 1, end);
        return node;
    }

    return sortedArrayToBST(values, 0, values.length - 1);
}