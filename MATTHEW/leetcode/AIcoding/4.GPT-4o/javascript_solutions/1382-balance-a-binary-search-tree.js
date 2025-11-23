function balanceBST(root) {
    const inorder = (node, arr) => {
        if (!node) return;
        inorder(node.left, arr);
        arr.push(node.val);
        inorder(node.right, arr);
    };

    const sortedArrayToBST = (arr, start, end) => {
        if (start > end) return null;
        const mid = Math.floor((start + end) / 2);
        const node = new TreeNode(arr[mid]);
        node.left = sortedArrayToBST(arr, start, mid - 1);
        node.right = sortedArrayToBST(arr, mid + 1, end);
        return node;
    };

    const arr = [];
    inorder(root, arr);
    return sortedArrayToBST(arr, 0, arr.length - 1);
}