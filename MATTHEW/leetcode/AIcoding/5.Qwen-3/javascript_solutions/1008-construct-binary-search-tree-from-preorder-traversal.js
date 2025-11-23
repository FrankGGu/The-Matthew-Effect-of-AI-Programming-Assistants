var bstFromPreorder = function(preorder) {
    const build = (low, high) => {
        if (preorder.length === 0 || low > high) return null;
        const root = new TreeNode(preorder[0]);
        let i = 1;
        while (i < preorder.length && preorder[i] < root.val) {
            i++;
        }
        preorder.splice(0, 1);
        root.left = build(low, root.val - 1);
        root.right = build(root.val + 1, high);
        return root;
    };
    return build(0, Infinity);
};