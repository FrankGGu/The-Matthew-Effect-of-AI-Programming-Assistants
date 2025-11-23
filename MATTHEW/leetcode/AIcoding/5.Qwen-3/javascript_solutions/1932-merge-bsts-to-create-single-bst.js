function mergeBsts(root1, root2) {
    function* inorderTraversal(node) {
        if (node) {
            yield* inorderTraversal(node.left);
            yield node.val;
            yield* inorderTraversal(node.right);
        }
    }

    function buildBST(values, start, end) {
        if (start > end) return null;
        const mid = Math.floor((start + end) / 2);
        const node = new TreeNode(values[mid]);
        node.left = buildBST(values, start, mid - 1);
        node.right = buildBST(values, mid + 1, end);
        return node;
    }

    const values1 = [];
    for (const val of inorderTraversal(root1)) {
        values1.push(val);
    }

    const values2 = [];
    for (const val of inorderTraversal(root2)) {
        values2.push(val);
    }

    const merged = [...values1, ...values2].sort((a, b) => a - b);
    return buildBST(merged, 0, merged.length - 1);
}