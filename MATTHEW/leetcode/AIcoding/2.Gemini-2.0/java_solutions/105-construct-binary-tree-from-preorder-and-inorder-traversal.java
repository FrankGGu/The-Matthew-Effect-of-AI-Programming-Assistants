class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        return build(preorder, 0, preorder.length - 1, inorder, 0, inorder.length - 1);
    }

    private TreeNode build(int[] preorder, int preStart, int preEnd, int[] inorder, int inStart, int inEnd) {
        if (preStart > preEnd) {
            return null;
        }

        int rootVal = preorder[preStart];
        TreeNode root = new TreeNode(rootVal);

        int rootIndexInorder = -1;
        for (int i = inStart; i <= inEnd; i++) {
            if (inorder[i] == rootVal) {
                rootIndexInorder = i;
                break;
            }
        }

        int leftSize = rootIndexInorder - inStart;

        root.left = build(preorder, preStart + 1, preStart + leftSize, inorder, inStart, rootIndexInorder - 1);
        root.right = build(preorder, preStart + leftSize + 1, preEnd, inorder, rootIndexInorder + 1, inEnd);

        return root;
    }
}