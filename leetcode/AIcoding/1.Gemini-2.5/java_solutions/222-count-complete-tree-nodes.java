class Solution {
    public int countNodes(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int leftHeight = getHeight(root.left);
        int rightHeight = getHeight(root.right);

        if (leftHeight == rightHeight) {
            return (1 << (leftHeight + 1)) + countNodes(root.right);
        } else {
            return (1 << (rightHeight + 1)) + countNodes(root.left);
        }
    }

    private int getHeight(TreeNode node) {
        if (node == null) {
            return -1;
        }
        int height = 0;
        while (node.left != null) {
            node = node.left;
            height++;
        }
        return height;
    }
}