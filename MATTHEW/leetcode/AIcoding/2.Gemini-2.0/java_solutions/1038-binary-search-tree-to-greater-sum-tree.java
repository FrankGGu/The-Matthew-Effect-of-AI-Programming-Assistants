class Solution {
    int sum = 0;
    public TreeNode bstToGst(TreeNode root) {
        reverseInorder(root);
        return root;
    }

    private void reverseInorder(TreeNode root) {
        if (root == null) return;
        reverseInorder(root.right);
        sum += root.val;
        root.val = sum;
        reverseInorder(root.left);
    }
}