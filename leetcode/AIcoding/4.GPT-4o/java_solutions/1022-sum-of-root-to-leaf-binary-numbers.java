public class Solution {
    public int sumNumbers(TreeNode root) {
        return sumHelper(root, 0);
    }

    private int sumHelper(TreeNode node, int currentSum) {
        if (node == null) {
            return 0;
        }
        currentSum = (currentSum << 1) | node.val;
        if (node.left == null && node.right == null) {
            return currentSum;
        }
        return sumHelper(node.left, currentSum) + sumHelper(node.right, currentSum);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}