public class Solution {
    public int countNodes(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int leftDepth = getDepth(root, true);
        int rightDepth = getDepth(root, false);
        if (leftDepth == rightDepth) {
            return (1 << leftDepth) - 1;
        } else {
            return 1 + countNodes(root.left) + countNodes(root.right);
        }
    }

    private int getDepth(TreeNode node, boolean isLeft) {
        int depth = 0;
        while (node != null) {
            depth++;
            if (isLeft) {
                node = node.left;
            } else {
                node = node.right;
            }
        }
        return depth;
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