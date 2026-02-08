class Solution {
    private int currentSum = 0;

    public TreeNode bstToGst(TreeNode root) {
        if (root == null) {
            return null;
        }

        bstToGst(root.right);

        currentSum += root.val;
        root.val = currentSum;

        bstToGst(root.left);

        return root;
    }
}