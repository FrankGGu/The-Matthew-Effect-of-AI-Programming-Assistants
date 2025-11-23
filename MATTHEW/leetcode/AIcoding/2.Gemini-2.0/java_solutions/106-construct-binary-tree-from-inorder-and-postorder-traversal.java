class Solution {
    public TreeNode buildTree(int[] inorder, int[] postorder) {
        return buildTreeHelper(inorder, 0, inorder.length - 1, postorder, 0, postorder.length - 1);
    }

    private TreeNode buildTreeHelper(int[] inorder, int inStart, int inEnd, int[] postorder, int postStart, int postEnd) {
        if (inStart > inEnd) {
            return null;
        }

        int rootVal = postorder[postEnd];
        TreeNode root = new TreeNode(rootVal);

        int rootIndexInInorder = -1;
        for (int i = inStart; i <= inEnd; i++) {
            if (inorder[i] == rootVal) {
                rootIndexInInorder = i;
                break;
            }
        }

        int leftSubtreeSize = rootIndexInInorder - inStart;

        root.left = buildTreeHelper(inorder, inStart, rootIndexInInorder - 1, postorder, postStart, postStart + leftSubtreeSize - 1);
        root.right = buildTreeHelper(inorder, rootIndexInInorder + 1, inEnd, postorder, postStart + leftSubtreeSize, postEnd - 1);

        return root;
    }
}