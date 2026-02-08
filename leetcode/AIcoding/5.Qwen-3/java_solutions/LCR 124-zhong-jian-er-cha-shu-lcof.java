public class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        return buildTree(preorder, 0, preorder.length - 1, inorder, 0, inorder.length - 1);
    }

    private TreeNode buildTree(int[] preorder, int preStart, int preEnd, int[] inorder, int inStart, int inEnd) {
        if (preStart > preEnd || inStart > inEnd) {
            return null;
        }
        TreeNode root = new TreeNode(preorder[preStart]);
        int rootIndex = inStart;
        while (inorder[rootIndex] != root.val) {
            rootIndex++;
        }
        int leftSubtreeSize = rootIndex - inStart;
        root.left = buildTree(preorder, preStart + 1, preStart + leftSubtreeSize, inorder, inStart, rootIndex - 1);
        root.right = buildTree(preorder, preStart + leftSubtreeSize + 1, preEnd, inorder, rootIndex + 1, inEnd);
        return root;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}