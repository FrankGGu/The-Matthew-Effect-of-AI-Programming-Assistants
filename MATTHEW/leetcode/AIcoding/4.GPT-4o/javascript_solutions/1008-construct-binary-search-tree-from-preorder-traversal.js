function bstFromPreorder(preorder) {
    function buildTree(bounds) {
        if (index === preorder.length || preorder[index] < bounds[0] || preorder[index] > bounds[1]) {
            return null;
        }
        const rootValue = preorder[index++];
        const root = new TreeNode(rootValue);
        root.left = buildTree([bounds[0], rootValue]);
        root.right = buildTree([rootValue, bounds[1]]);
        return root;
    }

    let index = 0;
    return buildTree([-Infinity, Infinity]);
}