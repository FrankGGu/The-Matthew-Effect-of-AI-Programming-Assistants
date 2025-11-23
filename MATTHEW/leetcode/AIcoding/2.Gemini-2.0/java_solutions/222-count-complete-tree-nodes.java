class Solution {
    public int countNodes(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int leftHeight = 0;
        TreeNode leftNode = root;
        while (leftNode != null) {
            leftHeight++;
            leftNode = leftNode.left;
        }

        int rightHeight = 0;
        TreeNode rightNode = root;
        while (rightNode != null) {
            rightHeight++;
            rightNode = rightNode.right;
        }

        if (leftHeight == rightHeight) {
            return (1 << leftHeight) - 1;
        } else {
            return 1 + countNodes(root.left) + countNodes(root.right);
        }
    }
}