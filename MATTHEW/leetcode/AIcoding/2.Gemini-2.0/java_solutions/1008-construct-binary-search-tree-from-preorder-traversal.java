class Solution {
    int preIndex = 0;
    public TreeNode bstFromPreorder(int[] preorder) {
        return bstFromPreorderHelper(preorder, Integer.MAX_VALUE);
    }

    private TreeNode bstFromPreorderHelper(int[] preorder, int bound) {
        if (preIndex == preorder.length || preorder[preIndex] > bound) {
            return null;
        }

        TreeNode root = new TreeNode(preorder[preIndex++]);
        root.left = bstFromPreorderHelper(preorder, root.val);
        root.right = bstFromPreorderHelper(preorder, bound);

        return root;
    }
}