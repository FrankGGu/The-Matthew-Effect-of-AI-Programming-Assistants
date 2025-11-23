var bstFromPreorder = function(preorder) {
    let index = 0;

    function helper(bound) {
        if (index === preorder.length || preorder[index] > bound) {
            return null;
        }

        let root = new TreeNode(preorder[index]);
        index++;
        root.left = helper(root.val);
        root.right = helper(bound);
        return root;
    }

    return helper(Infinity);
};